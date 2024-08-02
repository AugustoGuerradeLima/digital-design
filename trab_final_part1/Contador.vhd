library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador is
    port (
        Clock   : in  std_logic;
        Reset   : in  std_logic;
        Control : in  std_logic;
        Start   : in  std_logic_vector(3 downto 0);
        Enable  : in  std_logic;
        Count   : out std_logic_vector(3 downto 0)
    );
end Contador;

architecture Behavioral of Contador is
    signal cnt : std_logic_vector(3 downto 0) := (others => '0');
    signal W_int : integer := 15;
    signal counting_up : boolean := true;
begin
    process (Clock, Reset)
    begin
        if Reset = '1' then
            cnt <= Start;
            counting_up <= Control = '1';
        elsif rising_edge(Clock) then
            if Enable = '1' then
                if Control = '1' then
                    if counting_up then
                        if to_integer(unsigned(cnt)) < W_int then
                            cnt <= std_logic_vector(unsigned(cnt) + 1);
                        else
                            counting_up <= false;
                            cnt <= std_logic_vector(unsigned(cnt) - 1);
                        end if;
                    else
                        if to_integer(unsigned(cnt)) > 0 then
                            cnt <= std_logic_vector(unsigned(cnt) - 1);
                        else
                            counting_up <= true;
                            cnt <= std_logic_vector(unsigned(cnt) + 1);
                        end if;
                    end if;
                elsif Control = '0' then
                    if counting_up then
                        if to_integer(unsigned(cnt)) > 0 then
                            cnt <= std_logic_vector(unsigned(cnt) - 1);
                        else
                            counting_up <= false;
                            cnt <= std_logic_vector(unsigned(cnt) + 1);
                        end if;
                    else
                        if to_integer(unsigned(cnt)) < W_int then
                            cnt <= std_logic_vector(unsigned(cnt) + 1);
                        else
                            counting_up <= true;
                            cnt <= std_logic_vector(unsigned(cnt) - 1);
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    Count <= cnt;
end Behavioral;
