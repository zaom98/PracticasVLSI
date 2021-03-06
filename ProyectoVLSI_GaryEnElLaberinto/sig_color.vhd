library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sig_color is
    Port ( FILA : in  integer;
           COLUMNA : in  integer;
			  NIVEL : in integer;
           COLOR_UP : out  integer;
           COLOR_DW : out  integer;
           COLOR_LF : out  integer;
           COLOR_RG : out  integer);
end sig_color;

architecture Behavioral of sig_color is

type mem_matrix is array (0 to 23, 0 to 31) of integer;

constant nivel_1 : mem_matrix := (
	(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
	(1,1,1,7,7,7,8,7,7,7,7,7,7,7,7,7,7,7,8,9,9,8,8,9,8,8,8,8,2,2,2,1),
	(1,1,1,7,7,7,9,7,7,8,8,9,8,8,7,7,9,8,8,9,9,8,7,7,7,7,7,8,8,2,2,1),
	(1,1,1,8,9,7,8,7,8,9,7,7,7,8,7,8,8,7,9,7,7,8,8,8,9,8,8,8,8,7,2,1),
	(1,1,1,7,7,7,7,7,8,7,7,8,7,8,7,7,7,8,8,7,7,7,7,7,7,7,7,7,7,7,7,1),
	(1,1,1,8,7,8,8,7,8,7,7,8,9,14,2,2,7,8,7,9,8,8,8,7,8,8,8,14,14,8,7,1),
	(1,1,1,7,7,7,8,7,7,7,7,7,8,14,14,8,7,7,7,7,8,8,8,7,8,2,2,14,8,14,8,1),
	(1,1,1,7,7,7,9,7,7,14,8,7,8,7,7,8,8,9,7,7,7,7,7,7,8,2,2,7,7,8,8,1),
	(1,1,1,8,7,14,14,7,14,14,7,7,7,7,9,7,14,9,14,7,8,9,7,7,7,7,7,7,9,8,14,1),
	(1,1,1,9,7,7,14,7,8,7,8,7,8,7,7,7,8,8,8,14,12,8,9,7,7,7,9,7,8,14,8,1),
	(1,1,1,7,7,8,9,7,8,9,14,14,8,8,9,8,8,9,14,14,12,8,8,7,14,9,8,7,7,7,8,1),
	(1,1,1,7,8,9,8,7,8,7,8,7,14,2,2,8,2,2,8,8,8,7,7,7,8,14,8,8,9,7,7,1),
	(1,1,1,7,9,7,7,7,7,7,9,14,8,7,7,7,7,7,8,9,7,7,12,7,7,8,2,2,8,9,7,1),
	(1,1,1,7,8,9,8,9,9,7,7,8,7,7,7,9,7,7,8,7,7,12,12,12,7,7,7,2,14,14,7,1),
	(1,1,1,7,7,8,8,9,9,7,7,7,7,8,8,8,8,7,8,14,7,7,12,7,7,14,7,2,14,7,7,1),
	(1,1,1,9,7,7,8,8,8,8,8,7,7,7,9,8,9,7,14,8,8,7,7,7,14,7,7,2,8,7,7,1),
	(1,1,1,9,9,7,8,8,8,7,9,8,9,7,7,8,8,7,7,7,8,8,7,14,2,2,7,8,9,9,9,1),
	(1,1,1,9,7,7,7,7,14,7,7,7,7,7,7,9,7,9,8,7,7,9,7,7,7,7,7,7,8,9,2,1),
	(1,1,1,7,7,8,12,7,14,14,14,12,8,9,7,7,7,7,9,7,7,7,9,8,7,2,9,7,9,2,2,1),
	(1,1,1,8,8,8,7,7,14,7,14,12,8,9,8,7,7,9,8,8,8,7,8,7,8,8,2,7,7,7,2,1),
	(1,1,1,8,8,7,7,9,8,7,8,12,8,8,7,7,8,9,9,8,7,7,7,7,12,8,2,2,8,7,8,1),
	(1,1,1,12,12,7,9,8,12,7,8,8,12,8,7,7,7,7,7,7,7,9,7,12,12,12,8,2,8,6,6,1),
	(1,1,1,12,12,7,7,7,7,7,7,12,12,8,8,9,8,12,12,12,12,8,8,12,12,12,8,2,8,6,6,1),
	(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
	);

constant nivel_2 : mem_matrix := (
	(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
	(1,1,1,9, 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 7, 7, 7, 8, 7, 7, 7, 8, 7, 7, 7, 14,11,14,11,1),
	(1,1,1,9, 14,8, 14,14,7, 8, 7, 8, 7, 11,7, 7, 7, 8, 7, 14,9, 14,7, 7, 7, 14,7, 8, 2, 2, 2, 1),
	(1,1,1,9, 12,12,8, 7, 7, 14,7, 8, 14,8, 8, 8, 14,14,7, 8, 14,8, 7, 14,14,14,7, 8, 2, 8, 8, 1),
	(1,1,1,9, 14,14,8, 7, 14,7, 7, 8, 9, 9, 9, 14,9, 9, 7, 7, 7, 7, 7, 14,7, 14,7, 14,2, 11,11,1),
	(1,1,1,9, 8, 11,14,14,8, 8, 7, 9, 9, 14,9, 9, 9, 14,14,7, 8, 8, 8, 7, 7, 14,7, 8, 2, 8, 8, 1),
	(1,1,1,7, 7, 7, 7, 7, 7, 7, 7, 14,14,14,14,14,14,7, 14,7, 7, 7, 14,14,12,7, 7, 8, 7, 7, 7, 1),
	(1,1,1,7, 14,14,2, 14,14,14,7, 7, 7, 14,7, 7, 7, 7, 14,14,14,7, 14,7, 7, 7, 14,8, 14,8, 7, 1),
	(1,1,1,7, 14,11,11,14,2, 14,14,14,7, 14,7, 14,14,7, 7, 7, 7, 7, 14,14,12,7, 7, 7, 7, 8, 7, 1),
	(1,1,1,7, 14,11,11,14,7, 7, 7, 7, 7, 14,7, 7, 14,14,14,14,2, 9, 9, 2, 7, 11,14,8, 7, 8, 7, 1),
	(1,1,1,7, 14,11,11,14,7, 11,11,7, 14,14,14,7, 7, 7, 7, 7, 9, 11,11,9, 7, 14,7, 8, 7, 8, 7, 1),
	(1,1,1,7, 14,14,14,14,7, 7, 7, 7, 14,9, 9, 7, 14,7, 14,7, 9, 11,11,9, 7, 14,7, 8, 7, 7, 7, 1),
	(1,1,1,7, 14,2, 2, 7, 12,14,14,12,14,14,12,14,14,12,14,7, 2, 9, 9, 2, 7, 11,7, 8, 8, 8, 7, 1),
	(1,1,1,7, 14,14,14,7, 14,7, 7, 7, 7, 7, 7, 7, 9, 9, 7, 7, 8, 8, 7, 14,7, 14,7, 7, 7, 7, 7, 1),
	(1,1,1,7, 7, 7, 7, 7, 8, 7, 14,14,14,14,14,14,9, 8, 7, 14,7, 8, 7, 7, 7, 14,7, 8, 14,8, 8, 1),
	(1,1,1,8, 14,14,8, 7, 14,7, 14,7, 7, 7, 7, 7, 7, 14,12,8, 7, 14,8, 14,7, 11,7, 7, 7, 7, 7, 1),
	(1,1,1,7, 7, 7, 7, 7, 14,7, 7, 14,7, 8, 14,8, 14,14,14,14,7, 8, 7, 7, 7, 8, 14,14,8, 8, 7, 1),
	(1,1,1,7, 14,8, 14,14,8, 14,7, 14,7, 8, 7, 7, 7, 14,11,14,7, 8, 14,8, 7, 7, 7, 7, 7, 7, 7, 1),
	(1,1,1,7, 7, 7, 8, 7, 7, 7, 7, 14,7, 7, 7, 8, 7, 7, 2, 8, 7, 7, 7, 8, 14,8, 8, 14,8, 11,11,1),----
	(1,1,1,7, 8, 14,14,7, 14,14,14,14,14,14,14,14,14,14,7, 14,14,14,7, 14,7, 7, 7, 7, 14,9, 9, 1),
	(1,1,1,7, 7, 7, 7, 7, 7, 14,9, 9, 7, 7, 7, 7, 14,7, 7, 9, 11,14,7, 8, 7, 8, 14,7, 7, 7, 9, 1),
	(1,1,1,9, 14,9, 14,14,12,11,6, 6, 11,12,14,7, 14,7, 8, 14,14,14,7, 14,7, 14,7, 7, 14,8, 9, 1),
	(1,1,1,9, 14,12,12,14,12,11,6, 6, 11,12,14,7, 9, 7, 7, 7, 7, 7, 7, 7, 7, 14,7, 14,8, 9, 9, 1),
	(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
	);
	
constant nivel_3 : mem_matrix := (
	(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
	(1,1,1,7,7,7,8,7,7,7,7,7,7,7,7,12,12,12,7,7,7,7,7,7,7,12,7,7,7,7,12,1),
	(1,1,1,7,7,7,8,7,7,12,12,14,14,14,7,7,7,7,7,14,14,14,14,9,7,7,7,8,12,7,12,1),
	(1,1,1,9,7,8,12,7,7,12,14,14,2,2,8,8,8,8,8,2,2,2,2,8,8,8,8,7,7,7,7,1),
	(1,1,1,9,7,14,12,7,7,12,14,14,2,11,11,2,11,2,11,11,11,2,11,11,11,11,8,7,2,2,7,1),
	(1,1,1,7,7,14,12,7,7,12,12,14,2,11,7,7,7,7,7,7,7,7,7,7,7,7,8,7,2,2,7,1),
	(1,1,1,7,9,8,12,12,7,7,7,8,2,11,7,14,14,14,14,7,7,7,7,7,9,7,8,7,7,7,7,1),
	(1,1,1,7,9,11,8,12,12,12,7,8,2,11,7,7,7,7,7,7,9,9,9,7,7,7,8,7,7,7,7,1),
	(1,1,1,7,7,7,11,8,12,12,7,8,2,2,2,2,7,11,7,7,14,14,14,7,7,7,7,8,2,7,2,1),
	(1,1,1,9,7,7,11,8,11,11,7,8,2,2,2,2,7,7,7,7,7,7,7,7,11,11,7,7,8,7,7,1),
	(1,1,1,7,7,8,8,7,7,7,7,2,2,2,2,2,9,9,9,7,7,14,11,7,2,2,11,7,14,2,7,1),
	(1,1,1,7,8,7,7,7,11,7,7,2,2,2,2,2,6,6,9,7,7,14,11,7,2,2,11,7,14,7,7,1),
	(1,1,1,7,14,7,11,11,11,11,11,2,2,2,2,2,6,6,9,7,7,14,7,7,11,7,11,7,14,7,2,1),
	(1,1,1,7,8,7,7,7,7,7,7,8,2,2,2,2,9,9,9,7,7,14,7,7,11,7,7,7,8,7,2,1),
	(1,1,1,7,11,8,14,14,8,2,7,8,2,2,2,2,7,7,7,7,7,7,7,7,14,7,7,8,7,7,2,1),
	(1,1,1,7,7,7,7,7,7,8,7,7,8,8,2,2,7,7,7,2,7,7,2,7,14,7,8,2,7,2,2,1),
	(1,1,1,11,11,9,11,9,7,14,7,7,7,8,9,9,11,7,7,7,7,2,7,7,7,7,7,8,7,7,2,1),
	(1,1,1,11,11,11,7,7,7,8,7,2,7,2,8,9,14,8,2,7,7,7,7,7,2,7,7,7,8,7,7,1),
	(1,1,1,8,8,8,7,11,8,7,7,7,7,2,8,7,7,7,7,2,2,2,2,2,2,11,7,7,11,14,7,1),
	(1,1,1,12,7,7,7,11,8,12,2,2,7,2,8,7,9,9,7,7,7,7,7,7,7,7,11,7,11,14,7,1),
	(1,1,1,12,7,12,12,11,8,12,2,2,7,8,2,7,9,9,12,14,14,14,14,14,8,7,7,7,11,14,7,1),
	(1,1,1,12,7,12,12,2,2,7,7,7,7,8,2,7,7,7,7,2,11,11,9,9,8,8,8,8,8,8,7,1),
	(1,1,1,12,7,7,7,7,7,7,12,12,12,8,2,12,12,12,7,7,7,7,7,7,7,7,7,7,7,7,7,1),
	(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
	);

	signal fila_p : integer range 0 to 23;
	signal colum_p : integer range 0 to 31;

begin

	--Se divide entre 32 porque de ese tama�o son los bloques
	fila_p <= FILA/32;
	colum_p <= COLUMNA/32;

	--Dependiendo del nivel a cada color se le asigna un elemento de las memorias con diferentes incrementos.
	--Si no esta en un nivel jugable entonces automaticamente asigna a todos un 1 (negro)
	process(NIVEL,FILA,COLUMNA)
	begin
		if (NIVEL = 1) then
			COLOR_UP <= nivel_1(fila_p - 1,colum_p);
			COLOR_DW <= nivel_1(fila_p + 1,colum_p);
			COLOR_LF <= nivel_1(fila_p,colum_p - 1);
			COLOR_RG <= nivel_1(fila_p,colum_p + 1);
		elsif (NIVEL = 2) then
			COLOR_UP <= nivel_2(fila_p - 1,colum_p);
			COLOR_DW <= nivel_2(fila_p + 1,colum_p);
			COLOR_LF <= nivel_2(fila_p,colum_p - 1);
			COLOR_RG <= nivel_2(fila_p,colum_p + 1);
		elsif (NIVEL = 3) then
			COLOR_UP <= nivel_3(fila_p - 1,colum_p);
			COLOR_DW <= nivel_3(fila_p + 1,colum_p);
			COLOR_LF <= nivel_3(fila_p,colum_p - 1);
			COLOR_RG <= nivel_3(fila_p,colum_p + 1);
		else
			COLOR_UP <= 1;
			COLOR_DW <= 1;
			COLOR_LF <= 1;
			COLOR_RG <= 1;

		end if;
	end process;
	
end Behavioral;

