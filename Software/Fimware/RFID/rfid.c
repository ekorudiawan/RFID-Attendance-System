/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 7/16/2012
Author  : 
Company : 
Comments: 


Chip type               : ATmega164A
Program type            : Application
AVR Core Clock frequency: 11.059200 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega164a.h>
#include <stdio.h>
#include <delay.h>
#include <string.h>

#define  LED_IND  PORTD.5
#define  BUZZER   PORTD.6
#define  SOLENOID PORTD.7

// Alphanumeric LCD Module functions
#include <alcd.h>

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

char kata1[16], kata2[16];

//// USART0 Receiver interrupt service routine
//interrupt [USART0_RXC] void usart0_rx_isr(void) {
//   char status,data;
//   status=UCSR0A;
//   data=UDR0;
//   if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0) {
//
//   }
//}

// USART1 Receiver interrupt service routine

unsigned int countDataRFID = 0;
bit dataComplete = 0;
unsigned char dataSerial[17];
unsigned char dataRFID[12];
unsigned char dataAsciiRFID[12];
interrupt [USART1_RXC] void usart1_rx_isr(void) {
   char status,data;
   status=UCSR1A;
   data=UDR1;
   if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0) {     
      dataSerial[countDataRFID]=data;
      countDataRFID++;
   }      
   if(countDataRFID>=16) {
      dataComplete=1;
      countDataRFID=0;
   }
}

char password[5];
int counter=0;
void scanKeypad() {
   lcd_gotoxy(0,1);
   lcd_puts("PIN : "); 
   PORTC=0b01111111;  
   delay_ms(30);  
   if(PINC.0==0) {          
      password[counter]='*';          
      lcd_gotoxy(counter+6,1);        
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');
      counter++;    
      BUZZER=1;  
      delay_ms(100);   
      BUZZER=0; 
   }
   if(PINC.1==0) {                  
      password[counter]='7';    
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*'); 
      counter++;     
      BUZZER=1;  
      delay_ms(100);  
      BUZZER=0; 
   }
   if(PINC.2==0) {              
      password[counter]='4';       
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');
      counter++;      
      BUZZER=1;  
      delay_ms(100);
      BUZZER=0; 
   }
   if(PINC.3==0) {           
      password[counter]='1';     
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');   
      counter++; 
      BUZZER=1;  
      delay_ms(100);  
      BUZZER=0; 
   }              
   PORTC=0b10111111;  
   delay_ms(30);  
   if(PINC.0==0) {  
      password[counter]='0'; 
      lcd_gotoxy(counter+6,1);         
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');    
      counter++;      
      BUZZER=1;  
      delay_ms(100);    
      BUZZER=0; 
   }
   if(PINC.1==0) {    
      password[counter]='8'; 
      lcd_gotoxy(counter+6,1);     
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');
      counter++;     
      BUZZER=1;  
      delay_ms(100);      
      BUZZER=0; 
   }
   if(PINC.2==0) { 
      password[counter]='5'; 
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');   
      counter++;  
      BUZZER=1;  
      delay_ms(100); 
      BUZZER=0; 
   }
   if(PINC.3==0) { 
      password[counter]='2';      
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');   
      counter++;    
      BUZZER=1;  
      delay_ms(100);  
      BUZZER=0; 
   }      
   PORTC=0b11011111;  
   delay_ms(30);  
   if(PINC.0==0) {  
      password[counter]='#';     
      lcd_gotoxy(counter+6,1);     
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');  
      counter++;    
      BUZZER=1;  
      delay_ms(100);  
      BUZZER=0; 
   }
   if(PINC.1==0) {    
      password[counter]='9'; 
      lcd_gotoxy(counter+6,1);     
      //lcd_putchar(password[counter]);  
      lcd_putchar('*'); 
      counter++;   
      BUZZER=1;  
      delay_ms(100); 
      BUZZER=0; 
   }
   if(PINC.2==0) { 
      password[counter]='6'; 
      lcd_gotoxy(counter+6,1);  
      //lcd_putchar(password[counter]);  
      lcd_putchar('*'); 
      counter++; 
      BUZZER=1;  
      delay_ms(100);  
      BUZZER=0; 
   }
   if(PINC.3==0) { 
      password[counter]='3';  
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');  
      counter++;  
      BUZZER=1;  
      delay_ms(100); 
      BUZZER=0; 
   }  
   PORTC=0b11101111;  
   delay_ms(30);  
   if(PINC.0==0) {  
      password[counter]='D';   
      lcd_gotoxy(counter+6,1);      
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');   
      counter++;  
      BUZZER=1;  
      delay_ms(100);  
      BUZZER=0; 
   }
   if(PINC.1==0) {    
      password[counter]='C';    
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');  
      counter++;   
      BUZZER=1;  
      delay_ms(100); 
      BUZZER=0; 
   }
   if(PINC.2==0) { 
      password[counter]='B';     
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');
      counter++;  
      BUZZER=1;  
      delay_ms(100); 
      BUZZER=0; 
   }
   if(PINC.3==0) { 
      password[counter]='A';      
      lcd_gotoxy(counter+6,1); 
      //lcd_putchar(password[counter]);  
      lcd_putchar('*');
      counter++; 
      BUZZER=1;  
      delay_ms(100); 
      BUZZER=0;  
   }                       
}

// Standard Input/Output functions
#include <stdio.h>
int i=0, j=0, k=0; 
 
// Declare your global variables here
// 3F 66 0A E6 E6 26 A6 OA E6 E6 A6 A6 0A
unsigned char* namaUser[] = {"Joko Setyawan   ","Rizky Gumilang  ","Bon Jovi        ","Tom Cruise      ","Susan           "};
unsigned char* nomorPin[] = {"024","032","123","234","541"};
unsigned char id1[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x06, 0x0F, 0x09, 0x00, 0x08, 0x0C}; 
unsigned char id2[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x08, 0x0A, 0x09, 0x0B, 0x06, 0x02};
unsigned char id3[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x04, 0x08, 0x06, 0x05, 0x05, 0x0E};
unsigned char id4[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x05, 0x08, 0x00, 0x02, 0x02, 0x09};
unsigned char id5[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x0A, 0x0D, 0x03, 0x05, 0x0E, 0x0B};

int bandingkanData() {
   int hasil;
   bit sama;
   bit selesai=0; 
   if(selesai==0) {
      sama=1;
      for(i=0;i<12;i++) {
         if(dataAsciiRFID[i]!=id1[i]){ 
            sama=0;
            break;
         }
      } 
      if(sama==1) {
         selesai = 1;
         hasil = 1;
      }   
   }  
   if(selesai==0) {
      sama=1;
      for(i=0;i<12;i++) {
         if(dataAsciiRFID[i]!=id2[i]){ 
            sama=0;
            break;
         }
      } 
      if(sama==1) {
         selesai = 1;
         hasil = 2;
      }   
   }    
   if(selesai==0) {
      sama=1;
      for(i=0;i<12;i++) {
         if(dataAsciiRFID[i]!=id3[i]){ 
            sama=0;
            break;
         }
      } 
      if(sama==1) {
         selesai = 1;
         hasil = 3;
      }   
   }   
   if(selesai==0) {
      sama=1;
      for(i=0;i<12;i++) {
         if(dataAsciiRFID[i]!=id4[i]){ 
            sama=0;
            break;
         }
      } 
      if(sama==1) {
         selesai = 1;
         hasil = 4;
      }   
   }  
   if(selesai==0) {
      sama=1;
      for(i=0;i<12;i++) {
         if(dataAsciiRFID[i]!=id5[i]){ 
            sama=0;
            break;
         }
      } 
      if(sama==1) {
         selesai = 1;
         hasil = 5;
      }   
   } 
   if(selesai==0) {
      hasil=0;
   }  
   return hasil;   
}

int noUser;

void main(void) {
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=1 State6=1 State5=1 State4=1 State3=P State2=P State1=P State0=P 
PORTC=0xFF;
DDRC=0xF0;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=0 State6=0 State5=0 State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0xE0;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2A output: Disconnected
// OC2B output: Disconnected
ASSR=0x00;
TCCR2A=0x00;
TCCR2B=0x00;
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-15: Off
// Interrupt on any change on pins PCINT16-23: Off
// Interrupt on any change on pins PCINT24-31: Off
EICRA=0x00;
EIMSK=0x00;
PCICR=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=0x00;

// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=0x00;

// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=0x00;

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 9600
UCSR0A=0x00;
UCSR0B=0x98;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x47;

// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud Rate: 9600
UCSR1A=0x00;
UCSR1B=0x98;
UCSR1C=0x06;
UBRR1H=0x00;
UBRR1L=0x47;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
ADCSRB=0x00;
DIDR1=0x00;

// ADC initialization
// ADC disabled
ADCSRA=0x00;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

// Alphanumeric LCD initialization
// Connections specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 0
// RD - PORTA Bit 1
// EN - PORTA Bit 2
// D4 - PORTA Bit 4
// D5 - PORTA Bit 5
// D6 - PORTA Bit 6
// D7 - PORTA Bit 7
// Characters/line: 16
lcd_init(16);    
lcd_clear();
LED_IND = 1;  
// Global enable interrupts
#asm("sei")
while (1) {
      bit pinSalah = 0;
      lcd_gotoxy(0,0);
      lcd_puts("RFID Reader     ");
      while(!dataComplete);
      dataComplete=0;   
      // Tampilkan ke Serial     
//      printf("Data Serial : ");
//      for(i=0;i<strlen(dataSerial);i++){
//         putchar(dataSerial[i]);
//      }

//      printf("Data RFID : ");                     
      // Ambil data RFID
      for(i=1;i<=12;i++) {
         dataRFID[i-1]=dataSerial[i];
//         putchar(dataRFID[i-1]);
//         putchar(' ');
      }          
      // Konvert Ke ASCII
      for(i=0;i<12;i++) {
         if ((dataRFID[i] >= '0') && (dataRFID[i] <= '9')) {
            dataAsciiRFID[i] = dataRFID[i] - '0';
         } else if ((dataRFID[i] >= 'A') && (dataRFID[i] <= 'F')) {
            dataAsciiRFID[i] = 10 + dataRFID[i] - 'A';
         }
      }  
//      printf("\r\nHasil ASCII : ");
//      for(i=0;i<12;i++) {
//         putchar(dataAsciiRFID[i]);
//      }    
      noUser = bandingkanData(); 
      if(noUser!=0) { 
      lcd_gotoxy(0,0);
      lcd_puts(namaUser[noUser-1]);
      delay_ms(2000);
      lcd_gotoxy(0,0);
      lcd_puts("Masukkan PIN    ");
      while(counter<3) {
         scanKeypad();
      }           
      password[4]='\0'; 
      lcd_clear();     
      switch(noUser) {
         case 1:  if(strcmp(nomorPin[0],password)==0) {  
                     SOLENOID = 1;     
                     printf("Joko Setyawan|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x06, 0x0F, 0x09, 0x00, 0x08, 0x0C}\r\n");
                     lcd_gotoxy(0,0);
                     lcd_puts("Silahkan Masuk  ");
                  }  
                  else{ 
                     pinSalah = 1; 
                     LED_IND = 0;
                     lcd_gotoxy(0,0);
                     lcd_puts("PIN Salah       ");
                  }  
                  break;
         case 2:  if(strcmp(nomorPin[1],password)==0) { 
                     SOLENOID = 1;  
                     printf("Rizky Gumilang|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x08, 0x0A, 0x09, 0x0B, 0x06, 0x02}\r\n");
                     lcd_gotoxy(0,0);
                     lcd_puts("Silahkan Masuk  ");
                  }     
                  else{           
                     pinSalah = 1; 
                     LED_IND = 0;
                     lcd_gotoxy(0,0);
                     lcd_puts("PIN Salah       ");
                  }    
                  break;
         case 3:  if(strcmp(nomorPin[2],password)==0) {   
                     SOLENOID = 1;  
                     printf("Bon Jovi|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x04, 0x08, 0x06, 0x05, 0x05, 0x0E}\r\n");
                     lcd_gotoxy(0,0);
                     lcd_puts("Silahkan Masuk  ");
                  }   
                  else{    
                     pinSalah = 1;  
                     LED_IND = 0;
                     lcd_gotoxy(0,0);
                     lcd_puts("PIN Salah       ");
                  }  
                  break;
         case 4:  if(strcmp(nomorPin[3],password)==0) {  
                     SOLENOID = 1;     
                     printf("Tom Cruise|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x05, 0x08, 0x00, 0x02, 0x02, 0x09}\r\n");
                     lcd_gotoxy(0,0);
                     lcd_puts("Silahkan Masuk  ");
                  }  
                  else{  
                     pinSalah = 1;   
                     LED_IND = 0;
                     lcd_gotoxy(0,0);
                     lcd_puts("PIN Salah       ");
                  }  
                  break;
         case 5:  if(strcmp(nomorPin[4],password)==0) { 
                     SOLENOID = 1;      
                     printf("Susan|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x0A, 0x0D, 0x03, 0x05, 0x0E, 0x0B}\r\n");
                     lcd_gotoxy(0,0);
                     lcd_puts("Silahkan Masuk  ");
                  }    
                  else{     
                     pinSalah = 1;  
                     LED_IND = 0;
                     lcd_gotoxy(0,0);
                     lcd_puts("PIN Salah       ");
                  }  
                  break;            
      }       
      counter=0;          
      }
      else{
         lcd_gotoxy(0,0);
         lcd_puts("Tidak Terdaftar ");
      }     
      if(pinSalah) {
         delay_ms(2000);   
         LED_IND = 1;
      }                 
      else {
         delay_ms(4000); 
         SOLENOID = 0;
      }  
   }
}
