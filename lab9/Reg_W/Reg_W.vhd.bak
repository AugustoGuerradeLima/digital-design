LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity Reg_W is
	generic
	(
		W: natural
	);

	port
		(		
				clock: in std_logic;
				load:  in std_logic;
				reset: in std_logic;
				D: 	 in std_logic_vector (W-1 downto 0);
				Q: 	 out std_logic_vector(W-1 downto 0)
		  );
end Reg_W;

architecture RTL of Reg_W is
begin
    process(clock, reset)
    begin
        if (reset = '1') then Q<=(others => '0');
		  
        elsif (clock='1' and clock'event) then if load = '1' then Q <= D;
        
		  end if;
        end if;
    end process;
end RTL;
