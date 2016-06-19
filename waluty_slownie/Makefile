CC = ghc
run: slownie
	./slownie 1234567890 HRK
slownie: Main.hs
	$(CC) Main.hs -fno-warn-tabs -o slownie
clean:
	rm slownie
	rm *.o
	rm *.hi

	 