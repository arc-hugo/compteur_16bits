----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2022 09:10:07
-- Design Name: 
-- Module Name: test_compteur_16bits - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_compteur_16bits is
--  Port ( );
end test_compteur_16bits;

architecture Behavioral of test_compteur_16bits is

component compteur_16bits

-- Composant compteur
Port ( Din : in STD_LOGIC_VECTOR (15 downto 0);
       Dout : out STD_LOGIC_VECTOR (15 downto 0);
       CK : in STD_LOGIC;
       RST : in STD_LOGIC;
       LOAD : in STD_LOGIC;
       SENS : in STD_LOGIC;
       EN : in STD_LOGIC);
end component;

-- Signaux locaux
signal CK_local: std_logic := '0';
signal RST_local: std_logic := '0';
signal EN_local: std_logic := '0';
signal LOAD_local: std_logic := '0';
signal SENS_local: std_logic := '0';
signal entree_vec: std_logic_vector(15 downto 0) := (others => '0');
signal sortie_vec: std_logic_vector(15 downto 0) := (others => '0');

-- Période d'horloge
constant Clock_period: time := 10ns;

begin

-- Raccorde les signaux locaux aux port du compteur
-- L'ordre de déclaration est à respecter
Label_uut: compteur_16bits Port Map ( --
    Din => entree_vec,
    Dout => sortie_vec,
    CK => CK_local,
    RST => RST_local,
    LOAD => LOAD_local,
    SENS => SENS_local,
    EN => EN_local
);

-- Processus de variation de l'horloge
CK_process: process
begin
    CK_local <= not(CK_local);
    wait for Clock_period/2;
end process;
-- Configuration du vecteur d'entrée
entree_vec <= X"5555";

-- Enclenchement après un certains temps
EN_local <= '1', '0' after 100ns;
-- Initialisation du reset dans les dernier instants
RST_local <= '1', '0' after 900ns, '1' after 950ns;
-- Compte, puis décompte, puis recompte
SENS_local <= '1', '0' after 500ns, '1' after 700ns;
-- Chargement de nouvelles valeurs
LOAD_local <= '1' after 950ns, '0' after 955ns;

end Behavioral;
