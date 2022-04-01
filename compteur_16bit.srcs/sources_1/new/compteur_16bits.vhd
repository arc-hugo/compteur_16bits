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
    Port ( Din : in STD_LOGIC_VECTOR (15 downto 0);
           Dout : out STD_LOGIC_VECTOR (15 downto 0);
           CK : in STD_LOGIC;
           RST : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           SENS : in STD_LOGIC;
           EN : in STD_LOGIC);
end compteur_16bits;

architecture Behavioral of compteur_16bits is
signal Aux: std_logic_vector (15 downto 0);
begin
    process (CK,RST,LOAD,EN,SENS) -- Liste de sensibilité (activation du process lors du changement)
    begin
        -- wait until rising_edge(CK); <- synchronisation mais incompatible avec la liste de sensibilité
        if RST='0' then
            Aux <= X"0000"; -- Remise à 0 du vecteur
            Dout <= (others => '0');
        elsif rising_edge(CK) then
            if LOAD='1' then
                Aux <= Din;
                Dout <= Din;
            elsif EN='0' then
                if SENS='0' then
                    Aux<=Aux-1;
                else
                    Aux <= Aux+1;
                end if;
                Dout <= Aux;
            end if;
        end if;
    end process;
end Behavioral;
