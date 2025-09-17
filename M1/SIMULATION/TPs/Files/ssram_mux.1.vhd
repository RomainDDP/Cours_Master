--------------------------------------------------------------------------------
-- Data & Adr buses muxed SSRAM
-- THIEBOLT Francois
--------------------------------------------------------------------------------

-- Definition des librairies
library IEEE;

-- Definition des portee d'utilisation
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Definition de l'entite
entity ssram_mux is

	generic (
		-- taille du bus adr/data multiplexe
		MBUS_WIDTH : natural := 128;

		-- taille de la ram en nombre de mots
		RAM_SIZE : natural := 64 );

	port (
		-- signaux de controle
		CS,RD,WR : in std_logic; -- actifs a l'etat bas
		CLK,ALE : in std_logic;

		-- bus d'adresse et de donnee multiplexe
		MBUS : inout std_logic_vector(MBUS_WIDTH-1 downto 0) );

end ssram_mux;

-- -----------------------------------------------------------------------------
-- Definition de l'architecture de la ssram
-- -----------------------------------------------------------------------------
architecture behavior of ssram_mux is

-- definition de la fonction log2
function log2 (I: in natural) return natural is
	variable ip : natural := 1; -- valeur temporaire
	variable iv : natural := 0; -- nb de bits
begin
	while ip < i loop
		ip := ip + ip; -- ou ip := ip * 2
		iv := iv + 1;
	end loop;
	-- renvoie le nombre de bits
	return iv;
end log2;

	-- definitions de types (index type default is integer)
	type FILE_REG_typ is array (0 to RAM_SIZE-1) of std_logic_vector(MBUS_WIDTH-1 downto 0);
	subtype L_ADR is std_logic_vector(log2(RAM_SIZE)-1 downto 0);

	-- definition de constantes
	constant DBUS_WIDTH : natural := MBUS_WIDTH;
	constant LAST_ADR : L_ADR := conv_std_logic_vector(RAM_SIZE-1, L_ADR'length);

	-- definition des ressources internes
	signal REGS	: FILE_REG_typ; -- le banc de registres
	signal LADR	: L_ADR; -- latch pour adresses (au format mot)
	signal RST	: std_logic; -- Reset interne, actif a l'etat bas
	signal LADROK	: std_logic; -- adresse interne (latch) n'a pas atteint la fin du banc mémoire

begin

-- Affectation combinatoire du signal RST qui sera echantillone
-- par les process sur le front montant d'horloge CLK. Actif a 0
RST <= (RD or WR); 
-- Affectation combinatoire du bus multiplexe MBUS
MBUS <= REGS(conv_integer(LADR)) when (CS='0' and RD='0' and RD /= WR and LADROK = '1') 
          else (others => 'Z');


-----------------------------------------------
-- Process P_LADR
-- Ne pas oublier que le latch suit l'evolution
-- de MBUS tant que ALE est actif
P_LADR: process(CLK, CS, ALE, MBUS)
begin
	-- test du front actif d'horloge
	if rising_edge(CLK) then
		-- test du reset
		if (RST='0') then
		  LADR <= LAST_ADR;
      LADROK <= '1';
    elsif (CS='0' and RD/=WR) then
			-- cycle lecture ou ecriture en cours et on vient d'ecrire
			-- il faut donc incrementer sauf si l'on est en fin de banc
      if (LADR /= LAST_ADR) then
        LADR <= LADR+1;
      else
        LADROK <= '0';
      end if;
		end if;
	end if;

	-- test du signal de latch
	if (ALE='1' and CS='0') then
	  LADR <= MBUS(log2(RAM_SIZE)-1 downto 0);
    LADROK <= '1';
  end if;
end process P_LADR;

-----------------
-- Process P_REGS
P_REGS: process(_________)
begin
	-- test du front actif d'horloge
	if (CLK'event and CLK='1') then
		-- test du reset
		if (RST='0') then
			__________________
		elsif (________________________________) then
			REGS(______) <= _____;
		end if;
	end if;
end process P_REGS;

end behavior;

