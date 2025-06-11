build:
	ca65 helloppu.asm -o helloppu.o
	ld65 -C nes.cfg helloppu.o -o helloppu.nes

clean:
	rm *.o *.nes

run:
	fceux helloppu.nes