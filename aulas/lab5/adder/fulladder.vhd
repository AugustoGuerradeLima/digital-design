LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fulladder is
    port ( Cin : in std_logic;
           x   : in std_logic;
           y   : in std_logic;
           s   : out std_logic;
           Cout : out std_logic
        );
end fulladder;

architecture Behavioral of fulladder is
begin
    process (Cin, x, y)
    begin
        if ((x = '0' and y = '0' and Cin = '1') or (x = '1' and y = '0' and Cin = '0') or (x = '0' and y = '1' and Cin = '0')) then
            s <= '1';
        elsif ((x = '1' and y = '1' and Cin = '0') or (x = '0' and y = '1' and Cin = '1') or (x = '1' and y = '0' and Cin = '1')) then
            s <= '0';
		  elsif(x = '1' and y = '1' and Cin = '1') then
				s <= '1';
        else
            s <= '0';
        end if;

        if ((x = '1' and y = '1') or (x = '1' and Cin = '1') or (y = '1' and Cin = '1')) then
            Cout <= '1';
        else
            Cout <= '0';
        end if;
    end process;
end Behavioral;