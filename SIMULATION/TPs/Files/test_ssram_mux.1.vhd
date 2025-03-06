----------------------------------
-- Fichier de test de SSRAM
-- THIEBOLT Francois
----------------------------------

------------------------------------------------------------------
-- VHDL'93 ONLY
-- On ne redeclare pas les composants utilises
------------------------------------------------------------------

-- Definition des librairies
library IEEE;

-- Definition des portee d'utilisation
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- Definition de l'entite
entity test_ssram_mux is
end test_ssram_mux;

-- Definition de l'architecture
architecture behavior of test_ssram_mux is

-- definition des constantes
	constant S_DATA		: positive := 8; -- taille du bus de donnes
	constant S_RAM		: positive := 12; -- taille de la RAM en nb de mots
--	constant RWFRONT 	: std_logic := '0'; -- front actif pour lecture/ecriture
	constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal E_CLK		: std_logic;
signal E_CS,E_RD,E_WR	: std_logic; -- actifs a l'etat bas
signal E_MBUS		: std_logic_vector(S_DATA-1 downto 0);
signal E_ALE		: std_logic;

begin

--------------------------
-- definition de l'horloge
P_E_CLK: process
begin
	E_CLK <= '1';
	wait for clkpulse;
	E_CLK <= '0';
	wait for clkpulse;
end process P_E_CLK;

-----------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "TIMEOUT SIMULATION !!!" severity FAILURE;
end process P_TIMEOUT;

----------------------------------------------
-- instanciation et mapping du composant ssram
ssram1 : entity work.ssram_mux(behavior)
			generic map (S_DATA,S_RAM)
			port map (E_CS,E_RD,E_WR,E_CLK,E_ALE,E_MBUS);

-----------------------------
-- debut sequence de test
P_TEST: process
begin

	-- initialisations
	E_CS <= '1';
	E_ALE <= '0';
	E_RD <= '1';
	E_WR <= '1';
	E_MBUS <= (others=>'Z');

	-- sequence RESET
	wait for clkpulse/4;
	E_RD <= '0';
	E_WR <= '0';
	wait until (E_CLK='1'); -- front montant horloge
	wait for clkpulse/4;
	E_RD <= '1';
	E_WR <= '1';
	
	-- latching ADR
	E_ALE <= '1';
	E_MBUS <= conv_std_logic_vector(16#F883#,S_DATA);
	wait until (E_CLK='1'); -- front montant horloge
	wait for clkpulse/4;
	E_CS <= '0';
	wait for clkpulse/4;
	E_MBUS <= conv_std_logic_vector(S_RAM-3,S_DATA); -- LADR=9;
	wait until (E_CLK='1'); -- front montant horloge
	wait for clkpulse/4;
	E_CS <= '1';
	E_MBUS <= conv_std_logic_vector(16#F88F#,S_DATA);
	wait for clkpulse/4;
	E_ALE <= '0';

	-- ecriture dans ssram
	for i in S_RAM-3 to S_RAM+1 loop -- pour etre sur de deborder
		wait until (E_CLK='1'); -- front montant horloge
		wait for clkpulse/4; -- on attend 1/8 de periode d'horloge
		E_WR <= '0';
		E_CS <= '0';
		E_MBUS <= conv_std_logic_vector(i**2,S_DATA);	
	end loop;
	wait until (E_CLK='1'); -- front montant horloge
	wait for clkpulse/4; -- on attend 1/8 de periode d'horloge
	E_WR <= '1';

	-- activation ALE
	wait until (E_CLK='1'); -- front montant horloge
	wait for clkpulse/4; -- on attend 1/8 de periode d'horloge
	E_MBUS <= conv_std_logic_vector(S_RAM-2,S_DATA); --LADR=10
	E_RD <= '1';
	E_WR <= '1';
	E_ALE <= '1';
	wait for clkpulse;
	E_ALE <= '0';

	-- lecture ssram
	for i in S_RAM-2 to S_RAM+1 loop -- pour etre sur de deborder
		wait until (E_CLK='1'); -- front montant horloge
		wait for clkpulse/4; -- on attend 1/8 de periode d'horloge
		E_MBUS <= (others=>'Z');
		E_RD <= '0';
		E_CS <= '0';
	end loop;

	-- activation RD et WR simultanes mais pas front montant CLK
	wait until (E_CLK='1'); -- front montant horloge
	wait for clkpulse/4; -- on attend 1/8 de periode d'horloge
	E_CS <= '0';
	E_WR <= '0';
	E_RD <= '0';
	wait for clkpulse;
	E_RD <= '1';
	E_WR <= '1';
	
	-- ADD NEW SEQUENCE HERE

	-- LATEST COMMAND (NE PAS ENLEVER !!!)
	wait until (E_CLK='1'); -- front montant
	wait for clkpulse/4; -- on attend 1/8 de periode d'horloge
	
	assert FALSE report "FIN DE SIMULATION" severity FAILURE;
	-- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;

end process P_TEST;

end behavior;

