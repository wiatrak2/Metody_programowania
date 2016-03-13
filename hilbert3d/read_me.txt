Wojciech Pratkowiecki
Metody Programowania 2016 Lista zadań na pracownię nr 1

Folder zawiera:
	- pliki .c i .h będące rozwiązaniem zadnia
	- plik makefile umożliwiający kompilację kodu (testowany na:
		* OS X El Capitan 10.11.3
		* Ubuntu 15.10)
	- plik hilbert3D.exe będący skompilowanym programem

Program generuje plik w formacie Post Script zawierający rzut perspektywiczny krzywej Hilberta

Folder nie zawiera plików .o powstałych w czasie kompilacji


Przykładowa obsługa programu:
	- za pomocą terminala skompilować program komendą „make”
	- program powinien zostać wywołany z parametrami podanymi w treści zadania.
	- przykładowe wywołanie programu:
		./hilbert3D 5 3000 2400 2500 700 700 700 33 -33
	- po prawidłowym wywołaniu programu wyświetli się informacja:
		plik hilbert3D.eps został wygenerowany
	  wówczas w katalogu w którym znajduje się program pojawi się wygenerowany plik PostScript rzutem perspektywicznym krzywej Hilberta.