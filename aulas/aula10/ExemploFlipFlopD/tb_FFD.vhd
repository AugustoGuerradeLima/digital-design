library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;
 
ENTITY tb_FFD IS
END tb_FFD;
 
ARCHITECTURE behavior OF tb_FFD IS 
 
    -- Component Declaration for the Device Under Test (DUT)
 
component FFD 
	port( 
			D: in std_logic;
			rst: in std_logic;
			clock: in std_logic;
			Q: out std_logic
		);
end component;
    
	signal clk              : std_logic;
	signal rst              : std_logic;
	signal data_in          : std_logic;
	signal data_out         : std_logic;
	constant max_value      : natural := 4;
	constant min_value      : natural := 1;


   signal flag_read       : std_logic:='0';
   signal flag_write      : std_logic:='0';   

   
   file   inputs_data_in  : text open read_mode  is "data_in.txt";
   file   outputs_data_out: text open write_mode is "data_out.txt";


   -- Clock period definitions
   constant PERIOD     : time := 20 ns;
   constant DUTY_CYCLE : real := 0.5;
   constant OFFSET     : time := 5 ns;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT) or Design Under Test (DUT)
DUT: FFD 
    port map(	clock      => clk,
		rst        => rst,
		D          => data_in,
		Q          => data_out
	);
		  
------------------------------------------------------------------------------------
----------------- Processo para gerar o sinal de clock 
------------------------------------------------------------------------------------		
Processo_do_clock: PROCESS
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS Processo_do_clock;

------------------------------------------------------------------------------------
----------------- Processo para gerar o estimulo de reset
------------------------------------------------------------------------------------		
Processo_do_reset: process
	begin
		rst <= '1';
		for i in 1 to 4 loop
			wait until rising_edge(clk);
		end loop;
		rst <= '0'; 
		wait;	
	end process Processo_do_reset;
	
	
------------------------------------------------------------------------------------
----------------- processo para ler os dados do arquivo data_in.txt
------------------------------------------------------------------------------------
Processo_que_le_data_in:
   process
		variable linea : line;
		variable input : std_logic;
	begin
	   wait until falling_edge(clk);
		while not endfile(inputs_data_in) loop
		      if flag_read = '1' then
					readline(inputs_data_in,linea);
					read(linea,input);
					data_in <= input;
			  end if;
			  wait for PERIOD;
		end loop;
		wait;
	end process Processo_que_le_data_in;	
	
------------------------------------------------------------------------------------
----------------- processo para gerar os estimulos de entrada "flag_read"
------------------------------------------------------------------------------------
	
Processo_estimulos_ent: PROCESS
   BEGIN
        WAIT FOR (OFFSET + 3*PERIOD);
            flag_read <= '1';		
			for i in min_value to max_value loop
		        wait for PERIOD;
		    end loop;
            flag_read <= '0';		
		WAIT;
   END PROCESS Processo_estimulos_ent;	
   
------------------------------------------------------------------------------------
------ processo para gerar os estimulos de escrita "flag_write"
------------------------------------------------------------------------------------   
   
    Processo_estimulos_saida : PROCESS
    BEGIN
         WAIT FOR (OFFSET + 4*PERIOD);
             flag_write <= '1';
			 for i in min_value to (max_value+1) loop
		         wait for PERIOD;
		     end loop;
             flag_write <= '0';			
		 WAIT;
    END PROCESS Processo_estimulos_saida;   
   
-- ------------------------------------------------------------------------------------
-- ------ Processo para escrever os dados de saida no arquivo output.txt
-- ------------------------------------------------------------------------------------   
   
	Processo_que_escreve_output:process
		 variable linea  : line;
		 variable output : std_logic;
	 begin
	    wait until falling_edge(clk);
		 while true loop
			 if (flag_write ='1')then
				 output := data_out;
				 write(linea,output);
				 writeline(outputs_data_out,linea);
			 end if;
			 wait for PERIOD;
		 end loop; 
	 end Process Processo_que_escreve_output;   	
END;
