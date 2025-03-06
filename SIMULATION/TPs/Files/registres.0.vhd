-------------------------------------------------------------------------------
-- Banc de registres
-- F.Thiebolt
-------------------------------------------------------------------------------

--------------------------------------------------------------
-- Par defaut 32 registres de 32 bits avec lecture double port
--------------------------------------------------------------

-- Definition des librairies
library IEEE;

-- Definition des portee d'utilisation
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Definition de l'entite
entity registres is

	-- definition des parametres generiques
	generic	(
		-- largeur du bus de donnees par defaut
		DBUS_WIDTH	: integer := 32; -- registre de 32 bits par defaut

		-- largeur du bus adr pour acces registre soit 32 (2**5) par defaut
		ABUS_WIDTH	: integer := 5 );

	-- definition des entrees/sorties
	port 	(
		-- signaux de controle du Banc de registres
		W, CLK, RST : in std_logic;

		-- bus d'adresse et donnees
		ADR_A, ADR_B, ADR_W : in std_logic_vector(ABUS_WIDTH-1 downto 0);
        D : in std_logic_vector(DBUS_WIDTH-1 downto 0);
        
		-- Ports de sortie
		QA, QB : out std_logic_vector(DBUS_WIDTH-1 downto 0)
		);
end registres;


-------------------------------------------------------------------------------
-- REGISTRES architecture in a behavioral style
-------------------------------------------------------------------------------

-- Definition de l'architecture du banc de registres
architecture behavior of registres is

	-- definitions de types (index type default is integer)
	type FILE_REGS is array (integer range 0 to (2**ABUS_WIDTH)-1) of std_logic_vector (DBUS_WIDTH-1 downto 0);

	-- definition des ressources internes
	signal REGS : FILE_REGS; -- le banc de registres

begin

---------------------------------
-- affectation des bus en lecture

QA <= REGS (conv_integer(ADR_A)) when ADR_A /= conv_std_logic_vector(0, ABUS_WIDTH) else
    (others => '0');
QB <= REGS (conv_integer(ADR_B)) when ADR_B /= conv_std_logic_vector(0, ABUS_WIDTH) else
    (others => '0');

-----------------
-- Process P_REGS
P_REGS: process(RST, CLK, W)
begin
	-- test du reset
	if RST='0' then
		 REGS <= (others => (others => '0'));
	-- test front actif d'horloge
	elsif (CLK'event and CLK='1') then
		-- test si ecriture dans le registre
		if ((W='0') and ADR_W /= conv_std_logic_vector(0, ABUS_WIDTH)) then
			REGS(conv_integer(ADR_W)) <= D;
		end if;
	end if;
end process P_REGS;

end behavior;

