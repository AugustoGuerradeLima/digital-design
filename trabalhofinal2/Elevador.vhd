library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Elevador is
    Port (
        vetor_andar : in  std_logic_vector(15 downto 0);
        sentido     : in  std_logic; -- '1' para subindo, '0' para descendo
        pos_atual   : in  integer range 0 to 15;
        prox_andar  : out integer range 0 to 15;
        andar_achado: out std_logic -- '1' se encontrou um andar chamado, '0' caso contrÃ¡rio
    );
end Elevador;

