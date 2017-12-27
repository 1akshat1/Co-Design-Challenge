module shift_test ( 
	       input wire 	  clk,
	       input wire 	  reset,
	       
	       input wire [8:0]   address,
	       input wire 	  read,
	       output wire [31:0] readdata,
	       input wire 	  write, 
	       input wire [31:0]  writedata);
   
   reg signed [7:0] 			  template[0:15];
   reg signed [7:0] 			  sig[0:15];
   reg signed [15:0]			  result[0:15];
   //reg signed [31:0] 			  acc;
   //reg [8:0]					  j;
  reg 				  hw_ctl;
  reg 				  hw_ctl_old;
   
   wire [0:15]		  write_template;
   //wire [0:127]		  write_sig;
   wire 			  write_retval;
   wire 			  write_ctl;	
   wire 			  read_acc;
   
   wire [7:0]	   datain; //Data going in the shift register
   wire 			       shift;//New data to be put in
   wire 			       valid;//Valid window available for *
   wire [127:0]	   taps;//Values of the window
   wire [7:0]	index;
   
   shiftblock M1(clk,
		 reset,
		 datain,
		 shift,
		 valid,
		 taps,
		 index);
   // writing into shiftblock
   wire   loaddata;   
   assign loaddata  = (write & (address == 9'd0));
   assign shift     = loaddata;
   assign datain    = writedata[31:0];
   
   // max-accumulator logic
   reg signed [31:0] 			       sum;
   reg signed [31:0] 			       maxsum;
   reg 		  [7:0] 			       maxindex;
   reg 		  [7:0] 			       index_2;
   wire signed [31:0] 			       tapsum;
   wire 			       clearsum;
     
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
	  template[0]   <= 8'h0;
	  template[1]   <= 8'h0;
	  template[2]   <= 8'h0;
	  template[3]   <= 8'h0;
	  template[4]   <= 8'h0;
	  template[5]   <= 8'h0;
	  template[6]   <= 8'h0;
	  template[7]   <= 8'h0;
	  template[8]   <= 8'h0;
	  template[9]   <= 8'h0;
	  template[10]  <= 8'h0;
	  template[11]  <= 8'h0;
	  template[12]  <= 8'h0;
	  template[13]  <= 8'h0;
	  template[14]  <= 8'h0;
	  template[15]  <= 8'h0;
	  result[0] 	 <= 16'h0;
	  result[1] 	 <= 16'h0;
	  result[2] 	 <= 16'h0;
	  result[3] 	 <= 16'h0;
	  result[4] 	 <= 16'h0;
	  result[5] 	 <= 16'h0;
	  result[6] 	 <= 16'h0;
	  result[7] 	 <= 16'h0;
	  result[8] 	 <= 16'h0;
	  result[9] 	 <= 16'h0;
	  result[10] 	 <= 16'h0;
	  result[11] 	 <= 16'h0;
	  result[12] 	 <= 16'h0;
	  result[13] 	 <= 16'h0;
	  result[14] 	 <= 16'h0;
	  result[15] 	 <= 16'h0;
	  // hw_ctl      <= 1'h0;
	  // hw_ctl_old  <= 1'h0;
     end
     else
       begin
	  template[0]        <= write_template[0]      ? writedata[31:24]   : template[0];
	  template[1]        <= write_template[1]      ? writedata[23:16]   : template[1];
	  template[2]        <= write_template[2]      ? writedata[15:8]   : template[2];
	  template[3]        <= write_template[3]      ? writedata[7:0]   : template[3];
	  template[4]        <= write_template[4]      ? writedata[31:24]   : template[4];
	  template[5]        <= write_template[5]      ? writedata[23:16]   : template[5];
	  template[6]        <= write_template[6]      ? writedata[15:8]   : template[6];
	  template[7]        <= write_template[7]      ? writedata[7:0]   : template[7];
	  template[8]        <= write_template[8]      ? writedata[31:24]   : template[8];
	  template[9]        <= write_template[9]      ? writedata[23:16]   : template[9];
	  template[10]       <= write_template[10]     ? writedata[15:8]   : template[10];
	  template[11]       <= write_template[11]     ? writedata[7:0]   : template[11];
	  template[12]       <= write_template[12]     ? writedata[31:24]   : template[12];
	  template[13]       <= write_template[13]     ? writedata[23:16]   : template[13];
	  template[14]       <= write_template[14]     ? writedata[15:8]   : template[14];
	  template[15]       <= write_template[15]     ? writedata[7:0]   : template[15];
	  
	  result[0] 		 <= valid			? template[0] * sig[0] : result[0];
	  result[1] 		 <= valid			? template[1] * sig[1] : result[1];
 	  result[2] 		 <= valid			? template[2] * sig[2] :result[2];
	  result[3] 		 <= valid			? template[3] * sig[3] :result[3];
	  result[4] 		 <= valid			? template[4] * sig[4] :result[4];
	  result[5] 		 <= valid			? template[5] * sig[5] :result[5];
	  result[6] 		 <= valid			? template[6] * sig[6] :result[6];
	  result[7] 		 <= valid			? template[7] * sig[7] :result[7];
	  result[8] 		 <= valid			? template[8] * sig[8] :result[8];
	  result[9] 		 <= valid			? template[9] * sig[9] :result[9];
	  result[10] 		 <= valid			? template[10] * sig[10] :result[10];
	  result[11] 		 <= valid			? template[11] * sig[11] :result[11];
	  result[12] 		 <= valid			? template[12] * sig[12] :result[12];
	  result[13] 		 <= valid			? template[13] * sig[13] :result[13];
	  result[14] 		 <= valid			? template[14] * sig[14] :result[14];
	  result[15] 		 <= valid			? template[15] * sig[15] :result[15];
   	  
	
	end
assign tapsum = result[0]+result[1]+result[2]+result[3]+result[4]+result[5]+result[6]+result[7]+result[8]+result[9]+result[10]+result[11]+result[12]+result[13]+result[14]+result[15];

assign clearsum = (write & (address == 9'd23));

always@(posedge clk or posedge reset)
if (reset)
	begin
	sig[0]		<= 8'h0;
	sig[1]		<= 8'h0;
	sig[2]		<= 8'h0;
	sig[3]		<= 8'h0;
	sig[4]		<= 8'h0;
	sig[5]		<= 8'h0;
	sig[6]		<= 8'h0;
	sig[7]		<= 8'h0;
	sig[8]		<= 8'h0;
	sig[9]		<= 8'h0;
	sig[10]		<= 8'h0;
	sig[11]		<= 8'h0;
	sig[12]		<= 8'h0;
	sig[13]		<= 8'h0;
	sig[14]		<= 8'h0;
	sig[15]		<= 8'h0;
    sum <= 32'h0;
	maxsum <= 32'h0;
	maxindex <= 8'd0;
	end
else
	begin
	sig[0]			 <= valid	? taps[120 +: 8]:sig[0];
	sig[1]			 <= valid	? taps[112 +: 8]:sig[1];
	sig[2]			 <= valid	? taps[104 +: 8]:sig[2];
	sig[3]			 <= valid	? taps[96 +: 8]:sig[3];
	sig[4]			 <= valid	? taps[88 +: 8]:sig[4];
	sig[5]			 <= valid	? taps[80 +: 8]:sig[5];
	sig[6]			 <= valid	? taps[72 +: 8]:sig[6];
	sig[7]			 <= valid	? taps[64 +: 8]:sig[7];
	sig[8]			 <= valid	? taps[56 +: 8]:sig[8];
	sig[9]			 <= valid	? taps[48 +: 8]:sig[9];
	sig[10]			 <= valid	? taps[40 +: 8]:sig[10];
	sig[11]			 <= valid	? taps[32 +: 8]:sig[11];
	sig[12]			 <= valid	? taps[24 +: 8]:sig[12];
	sig[13]			 <= valid	? taps[16 +: 8]:sig[13];
	sig[14]			 <= valid	? taps[8 +: 8]:sig[14];
	sig[15]			 <= valid	? taps[0 +: 8]:sig[15];
    sum 			 <= (valid ) ? tapsum : sum;
	maxsum			 <= clearsum ? 32'h0 : (valid & (tapsum > maxsum)) ? tapsum : maxsum;
	maxindex		 <= clearsum ? 8'h0 : (valid & (tapsum > maxsum)) ? (index-16) : maxindex;
	index_2			 <= (valid ) ? (index-16) : index_2;
	end
  
 assign write_template[0]       = (write & (address == 9'd1));
 assign write_template[1]       = (write & (address == 9'd1));
 assign write_template[2]       = (write & (address == 9'd1));
 assign write_template[3]       = (write & (address == 9'd1));
 assign write_template[4]       = (write & (address == 9'd5));
 assign write_template[5]       = (write & (address == 9'd5));
 assign write_template[6]       = (write & (address == 9'd5));
 assign write_template[7]       = (write & (address == 9'd5));
 assign write_template[8]       = (write & (address == 9'd9));
 assign write_template[9]       = (write & (address == 9'd9));
 assign write_template[10]      = (write & (address == 9'd9));
 assign write_template[11]      = (write & (address == 9'd9));
 assign write_template[12]      = (write & (address == 9'd13));
 assign write_template[13]      = (write & (address == 9'd13));
 assign write_template[14]      = (write & (address == 9'd13));
 assign write_template[15]      = (write & (address == 9'd13));
 
	// reading from shiftblock
	wire 			       readtap0;
	wire 			       readtap1;
	wire 			       readtap2;
	wire 			       readtap3;
	wire                   readsum;
	wire                   readvalid;
	wire                   readmaxsum;
	wire                   readindex;
	wire                   readindex_2;
	assign readtap0  = (read & (address == 9'd14));
	assign readtap1  = (read & (address == 9'd15));
	assign readtap2  = (read & (address == 9'd16));
	assign readtap3  = (read & (address == 9'd17));
	assign readsum   = (read & (address == 9'd18));
	assign readvalid = (read & (address == 9'd19));
	assign readmaxsum = (read & (address == 9'd20));
	assign readindex = (read & (address == 9'd21));
	assign readindex_2 = (read & (address == 9'd22));

   assign readdata = readsum   ? sum         :
		     readvalid ? {31'h0, valid} :
		     readtap0  ? taps[ 31:  0]  :
		     readtap1  ? taps[ 63: 32]  :
		     readtap2  ? taps[ 95: 64]  :
		     readtap3  ? taps[127: 96]  :
			 readmaxsum  ? maxsum  		:
			 readindex  ? maxindex  	:
			 readindex_2  ? index_2  	:
		     32'h0;
 
 // assign write_ctl   	= (write & (address == 9'd2));
 
   
 // assign write_retval    = ((hw_ctl == 1'h1) & (hw_ctl ^ hw_ctl_old));
   
   
endmodule					   

module shiftblock(
		  input 	 clk,
		  input 	 reset,
		  input [7:0] 	 datain,
		  input 	 shift,
		  output 	 valid,
		  output [127:0] taps,
		  output [7:0] index
		  );

   reg [127:0] 			 frontreg;

   // 112-position shift reg input  = backin
   // 112-position shift reg output = backtaps[55:48]   
   wire 			 backregclken;
   wire [7:0] 			 backin;
   wire [7:0] 			 backout;
   wire [63:0] 			 backtaps; 			 
   shift112 backreg( backregen, clk, backin, backout, backtaps);

   reg [7:0] 			 count;
   wire 			 fill;
   
   always @(posedge clk or posedge reset)
     begin
	if (reset == 1'b1) 
	  begin
	     frontreg <= 128'h0;
	     count    <= 8'h0;
	  end
	else
	  begin
	     frontreg <= (fill & shift)    ? {frontreg[119:0], datain} :
			 (~fill)           ? {frontreg[119:0], backtaps[55:48]} :
			 frontreg;
	     count    <= (count == 8'd143) ? 8'h0 :
			 (fill & shift)    ? (count + 8'h1) :
			 (~fill)           ? (count + 8'h1) :
			 count;
	  end
     end
   
   assign fill      = (count < 8'd128);
   assign valid     = (count > 8'd15);
   assign taps      = frontreg;
   assign backregen = (fill & shift) | (~fill);
   assign backin    = frontreg[127:120];
   assign index 	= count;
 
endmodule




// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module shift112 (
	clken,
	clock,
	shiftin,
	shiftout,
	taps);

	input	  clken;
	input	  clock;
	input	[7:0]  shiftin;
	output	[7:0]  shiftout;
	output	[63:0]  taps;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clken;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [7:0] sub_wire0;
	wire [63:0] sub_wire1;
	wire [7:0] shiftout = sub_wire0[7:0];
	wire [63:0] taps = sub_wire1[63:0];

	altshift_taps	ALTSHIFT_TAPS_component (
				.clken (clken),
				.clock (clock),
				.shiftin (shiftin),
				.shiftout (sub_wire0),
				.taps (sub_wire1)
				// synopsys translate_off
				,
				.aclr (),
				.sclr ()
				// synopsys translate_on
				);
	defparam
		ALTSHIFT_TAPS_component.intended_device_family = "Cyclone V",
		ALTSHIFT_TAPS_component.lpm_hint = "RAM_BLOCK_TYPE=AUTO",
		ALTSHIFT_TAPS_component.lpm_type = "altshift_taps",
		ALTSHIFT_TAPS_component.number_of_taps = 8,
		ALTSHIFT_TAPS_component.tap_distance = 16,
		ALTSHIFT_TAPS_component.width = 8;


endmodule


