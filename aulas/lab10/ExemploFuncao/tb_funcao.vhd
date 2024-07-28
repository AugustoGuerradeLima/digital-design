library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

entity tb_funcao is
end tb_funcao;

architecture tb of tb_funcao is
component funcao is
port (
	x	:	in	std_logic_vector(3 downto 0);
	f	:	out	std_logic_vector(7 downto 0)
	);
end component;

signal xin		: std_logic_vector(3 downto 0);
signal fout		: std_logic_vector(7 downto 0);

signal flag_read  	: std_logic:='0';
signal flag_write      	: std_logic:='0';   
   
file   arquivo_entrada 	: text open read_mode  is "data_in.txt"; -- dados numericos de entrada
file   arquivo_saida1  	: text open write_mode is "saida1.txt"; -- saida resultado numerico
file   arquivo_saida2  	: text open write_mode is "saida2.txt"; -- saida diagnostico

constant OFFSET     	: time := 10 ns;
constant OFFSET_WRITE  	: time := 12 ns;
constant MEIO_OFFSET    : time := 5 ns;

type vetor_int is array (integer range <>) of integer;
--  Vetor com valores a serem comparados com resultados de saida para emitir diagnostico:
signal vetor		: vetor_int (0 to 8) := (88, 10, 108, 100, 88, 72, 52, 28, 0);
constant aux_string1	: string := "diferente";
constant aux_string2	: string := "igual";

begin

Cria_componente_funcao: funcao port map (x=>xin, f=>fout);

------------------------------------------------------------------------------------
-- processo para ler os dados do arquivo data_in.txt
------------------------------------------------------------------------------------
	le_entradas_do_arquivo:
	process
	  variable linha 	: line;
	  variable entrada 	: integer;
	  begin
	    wait for OFFSET;
		 while not endfile(arquivo_entrada) loop
		      if flag_read = '1' then
					readline(arquivo_entrada,linha);
					read(linha,entrada);
					xin <= std_logic_vector(to_unsigned(entrada,4));
			  end if;
			  wait for (MEIO_OFFSET);
	 	 end loop;
		 wait;
	 end process le_entradas_do_arquivo;
	 
------------------------------------------------------------------------------------
-- processo para gerar os estimulos da leitura da entrada xin 
------------------------------------------------------------------------------------
	autoriza_ler_entrada:
	process
	begin
		wait for OFFSET;
		flag_read <= '1';		
		for i in 0 to 8 loop
		    wait for MEIO_OFFSET;
		end loop;
        	flag_read <= '0';
		wait;
	end process autoriza_ler_entrada;
	
------------------------------------------------------------------------------------
-- processo p/ gerar os estimulos para escrita no arquivo_saida1 (resultados numéricos)
------------------------------------------------------------------------------------  
	autoriza_escrever_em_saida1:
	process
	begin
		wait for OFFSET_WRITE;
		flag_write <= '1';
		for i in 0 to 8 loop
			wait for MEIO_OFFSET;
		end loop;
		flag_write <= '0';			
		wait;
	end process autoriza_escrever_em_saida1; 
	
------------------------------------------------------------------------------------  
-- processo para testar os sinais simulados contra os resultados esperados e
-- gerar as saidas do arquivo_saida2 
------------------------------------------------------------------------------------  
	processo_que_escreve_saida2:
	process
	   variable aux 	: std_logic_vector (7 downto 0);
	   variable aux_int	: integer;
	   variable linha2  	: line;
	  begin
		wait for OFFSET_WRITE;
		flag_write <= '1';
		for i in 0 to 8 loop
			wait for MEIO_OFFSET;
			aux := fout;
			aux_int := to_integer(unsigned(aux));
			if(vetor(i)/=aux_int) then -- Compare resultado com vetor de resultados fornecido
				assert false report aux_string1 severity note;
				write(linha2,aux_string1);
				writeline(arquivo_saida2,linha2);
			else
				assert false report aux_string2 severity note;
				write(linha2,aux_string2);
				writeline(arquivo_saida2,linha2);
			end if;
		end loop;
		flag_write <= '0';			
		wait;
	  end process processo_que_escreve_saida2;   
   
------------------------------------------------------------------------------------  
-- processo para escrever os resultados numericos da funcao no arquivo_saida1  
------------------------------------------------------------------------------------   
	processo_que_escreve_saida1:
	process
	 variable linha1  	: line;
	 variable saida_aux 	: std_logic_vector (7 downto 0);
	begin
		wait for OFFSET_WRITE;
		while true loop
			if (flag_write ='1')then
				saida_aux := fout;
				write(linha1,to_integer(unsigned(saida_aux)));
				writeline(arquivo_saida1,linha1);
			end if;
			wait for MEIO_OFFSET;
		end loop; 
	end process processo_que_escreve_saida1;   	
end tb;
