# FPGA implementation of simple XOR cipher
Its objective is to encrypt or decrypt the plain text using a key. It is coded in Verilog. 
Due to the limited storage, smaller key size is preferred. Moreover, gLCD interface is used 
to demonstrate results and RS232 used to acquire data form a computer connection.

Block Diagram of Simple XOR Cipher
----------------------------------
![Alt text](/docs/block_diagram.png?raw=true "Simple XOR Cipher Block Diagram")


Module Descriptions
-------------------
**etext_RAM**
* It is specifically used to store output of the encrypter/decrypter block. The output is the encrypted data that is obtained from the encrypter/decrypter block and passes the information using its one read signal to the Connecter block in order to display information on the gLCD module.
* The data it holds can be obtained in one clock cycle. Thus, there are no particular timing constraints for this module.
* This memory block is a 16x8 bit RAM which has ability to be readed from and written to its memory locations. Its word length is 8bit and it consists 16 words inside. In case, it is wanted to write information, the address and the data are sent as an input of the block. In case, it is wanted to read information, the address of the information is sent as an input to the block and the data is obtained as a output. 

**ptext_ROM** and **key_ROM**
* This blocks holds the raw data written before hand. It sends the information to Connecter and the encrypter/decrypter block.
* The data it holds can be obtained in one clock cycle. Thus, there are no particular timing constraints for this module.
*	These memory blocks are 16x8 bit ROM. Its word length is 8bit and it consists 16 characters inside. In this implementation of it one read port is used. 

**encrypter/decrypter**
*	This block takes a key and a plain text then using a simple encryption/decryption algorithm it produces an output. It simply does bitwise XORing to all the characters which are located in the same index.
*	Since the process is just a logic operation, the data it holds can be obtained in one clock cycle. Thus, there are no particular timing constraints for this module.
*	In this block the key gets duplicated and its size becomes even with the text. After that key gets XORed with the text, the output goes to etext_RAM block in order to be stored.

**Copier**
*	It does copy a ram/rom into another ram with same size. 
*	The number of the clock cycles it takes is proportional to the number of the characters inside it. In this project max 16 characters is used so it takes 16 clock cycle at most. Inputs of the block are obtained with one clock cycle and the outputs, as it is explained above, are produced at most 16 clock cycle after.
*	It copies the information from one storage block to another. It is connected to two separate storage unit. One is called target and the other one is called source. This block iterates each 8bit data stored and copy them form source to target. 

**Connecter**
*	This block helps us to choose which source of storage the copier block will use. 
*	There are no timing constraints and delays for both inputs and outputs.
*	This block chooses a signal pair from a total of 3 possibilities. To do this it does use 2-bit enable signal from controller unit. According to the signal one of the three storage units will be connected to its outputs.

**gLCD**
*	This block controls the [Nokia 5110 gLCD module](https://www.sparkfun.com/products/10168) and displays the text outputs of the program. 
*	Since it uses the SPI connection protocol, the output is set to 50kHz. Thus, the time small time delay occurs.
*	This block takes the text data needed to be printed from Copier block and displays it. This text data can only comes form either etext_RAM or ptext_ROM or key_ROM module. Furthermore, there is a local storage unit called lcd_ram in the gLCD module.   
