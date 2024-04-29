--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    19:39:13 04/24/24
-- Design Name:    
-- Module Name:    FelipeWGB - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FelipeWGB is
    Port ( clk : in std_logic;
           rst : in std_logic;
           clk_in : in std_logic;
           disp : out std_logic_vector(7 downto 0);
           unid : out std_logic_vector(3 downto 0));
end FelipeWGB;

architecture Comportamental of FelipeWGB is

function decod (dgt : integer) return std_logic_vector is  
variable sda: std_logic_vector (7 downto 0);
begin
    if    dgt = 0 then sda := "11000000";
    elsif dgt = 1 then sda := "11111001";
    elsif dgt = 2 then sda := "10100100";
	 elsif dgt = 3 then sda := "10110000";
	 elsif dgt = 4 then sda := "10011001";
	 elsif dgt = 5 then sda := "10010010";
	 elsif dgt = 6 then sda := "10000011";
	 elsif dgt = 7 then sda := "11111000";
	 elsif dgt = 8 then sda := "10000000";
    else  sda := "00010000";
	 end if;
	 return (sda);
end decod;

signal seg: std_logic_vector(7 downto 0) := (others => '1');
signal trans: std_logic_vector(3 downto 0) := "1110";
signal cont: integer range 5000000 downto 0 := 0;
signal un: integer range 4 downto 0 := 0;
signal est: integer range 1 downto 0 := 0;

begin

process (clk, rst, clk_in)

begin
   if rst='1' then 
      seg <= (others => '1');
		trans <= "1110";
		cont <= 0;
		est <= 0;
		un <= 0;
   elsif clk='1' and clk'event then
		if clk_in = '1' and est = 0 then
			cont <= 0;
			est <= 1;
		elsif clk_in = '0' and est = 1 then
			cont <= cont + 1;
		end if;

		if cont = 5000000 then
			if un = 4 then
				un <= 0;
		   else
				un <= un + 1;
			end if;

			case un is
				when 0 =>
					seg <= decod(3);
				when 1 =>
					seg <= decod(8);
				when 2 =>
					seg <= decod(5);
				when 3 =>
					seg <= decod(7);
				when others =>
					seg <= decod(9);
			end case;
			est <= 0;
		end if;
   end if;
end process;

disp <= seg;
unid <= trans;

end Comportamental;
