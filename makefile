program: kolejka-send kolejka-receive

kolejka-send: kolejka-send.c
	gcc kolejka-send.c -o kolejka-send
	
kolejka-receive: kolejka-receive.c
	gcc kolejka-receive.c -o kolejka-receive
	
clean:
	rm kolejka-send kolejka-receive
