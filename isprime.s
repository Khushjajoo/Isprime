.globl isPrimeAssembly
isPrimeAssembly:
	//your code for iterating through arrays here
	//base addresses of arrays in X0 - X2, length in X3
	nop
	SUB 	SP, SP, #48   //allocate space for 3 arrays
	STUR	X0, [SP, #0]  //store X0 in stack
	STUR	X1, [SP, #16] //store X1 in stack
	STUR	X2, [SP, #32] //store X2 in stack
	ADD		X10, XZR, XZR //initialize i to 0
	forloop:
		SUBS	XZR, X10, X3 // check if i < length
		B.EQ 	Exit         // if i >= length, exit
		LDUR 	X5, [X0, #0] // load X0[i] into X5
		B isPrime            // call isPrime
		Next:
		SUBS XZR, X7, #1     // check if d == 1
		B.EQ prime          // if d == 1, it is prime
		STUR X5, [X2, #0]  // store X5 into composite array
		B incrementc

		prime:
			STUR X5,[X1, #0] // store X5 into prime array
			B incrementp
		incrementp:
			ADD X1, X1, #8  // increment prime array pointer
			B increment
		incrementc:
			ADD X2, X2, #8  // increment composite array pointer
			B increment
		increment:
			ADD X0, X0, #8   // increment X0 pointer
			ADD X10, X10, #1 // increment i
			B forloop
	Exit:
		LDUR	X0, [SP, #0]  //load X0 from stack
		LDUR	X1, [SP, #16] //load X1 from stack
		LDUR	X2, [SP, #32] //load X2 from stack
		ADD 	SP, SP, #48   //deallocate space for 3 arrays
		BR X30                //return to main



isPrime:
		ADD 	X15, XZR, XZR //initialize i to 0
		ADD 	X15, X15, #2  //set i to 2
		UDIV	X14, X5, X15  // divide n/2 and store in X14
		loopA:
			SUBS	XZR, X14, X15  // check if i < n/2
			B.EQ 	endloopA       // if i >= n/2, exit
			UDIV 	X11, X5, X15   // divide n/i and store in X11
			MUL		X12, X11, X15  
			SUBS 	XZR, X5, X12   // check if n%i == 0
			B.EQ 	endloopB
			ADD 	X15, X15, #1  // increment i
			B 	    loopA
		endloopA:
			ADD	    X7, XZR, XZR   // set d to 0
			ADD 	X7, X7, #1    // set d to 1    
			B 	    Next
		endloopB:
			ADD 	X7, XZR, XZR    // set d to 0
			B 	    Next

