----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2022 08:06:38
-- Design Name: 
-- Module Name: compteur_16bits - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur_16bits is
    Port ( Din : in STD_LOGIC_VECTOR (15 downto 0); -- in <- lisible mais non modifiable
           Dout : out STD_LOGIC_VECTOR (15 downto 0); -- out <- modifiable mais non lisible
           CK : in STD_LOGIC;
           RST : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           SENS : in STD_LOGIC;
           EN : in STD_LOGIC);
end compteur_16bits;

architecture Behavioral of compteur_16bits is
signal Aux: std_logic_vector (15 downto 0) := X"0000"; -- Signal auxiliaire pour Dout (lecture et écriture)
begin

    -- Chaque lignes dans un entity est considerée comme un process (concurent)

    process (CK,RST,LOAD,EN,SENS) -- Liste de sensibilité (activation du process lors du changement)
    begin
        -- wait until rising_edge(CK); <- synchronisation mais incompatible avec la liste de sensibilité
        if RST='0' then
            Aux <= X"0000"; -- Remise à 0 du vecteur ou (others => '0
        elsif rising_edge(CK) then -- CK'Edge and CK='1'
            if LOAD='1' then
                Aux <= Din; -- Chargement de Din dans Dout et Aux
            elsif EN='0' then
                if SENS='0' then
                    Aux<=Aux-1; -- Décrementation
                else
                    Aux<=Aux+1; -- Incrémentation
                end if;
            end if;
        end if;
    end process;
    
    -- Attribution concurente
    -- En dehors du précedent process pour ne pas perdre une période d'horloge dans le changement de valeur
    Dout <= Aux; -- Sortie de la nouvelle valeur
end Behavioral;
