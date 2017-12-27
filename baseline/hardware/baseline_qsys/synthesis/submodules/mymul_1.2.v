module mymul_1 ( 
	       input wire 	  clk,
	       input wire 	  reset,
	       
	       input wire [8:0]   address,
	       input wire 	  read,
	       output wire [31:0] readdata,
	       input wire 	  write, 
	       input wire [31:0]  writedata);
   
   reg signed [7:0] 			  template[0:15];
   reg signed [7:0] 			  sig[0:127];
   reg signed [15:0]			  result[0:15];
   reg signed [31:0] 			  acc;
   wire signed [31:0]			  sum;
   reg signed [31:0]			  sum_r;
   reg [8:0]					  j;
   reg 				  hw_ctl;
   reg 				  hw_ctl_old;
   
   wire [0:15]		  write_template;
   wire [0:127]		  write_sig;
   wire 			  write_retval;
   wire 			  write_ctl;	
   wire 			  read_acc;
   
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
	  sig[0]       	<= 8'h0;
	  sig[1]        <= 8'h0;
	  sig[2]        <= 8'h0;
	  sig[3]        <= 8'h0;
	  sig[4]        <= 8'h0;
	  sig[5]        <= 8'h0;
	  sig[6]        <= 8'h0;
	  sig[7]        <= 8'h0;
	  sig[8]        <= 8'h0;
	  sig[9]        <= 8'h0;
	  sig[10]       <= 8'h0;
	  sig[11]       <= 8'h0;
	  sig[12]       <= 8'h0;
	  sig[13]       <= 8'h0;
	  sig[14]       <= 8'h0;
	  sig[15]       <= 8'h0;
	  j				<= 9'd0;
	  //sum_r			<= 32'd0;
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
	  acc		 <= 32'h0;
	  hw_ctl      <= 1'h0;
	  hw_ctl_old  <= 1'h0;
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
	  sig[0]        <= write_sig[0]      ? writedata[7:0]   : sig[0];
	  sig[1]        <= write_sig[1]      ? writedata[7:0]   : sig[1];
	  sig[2]        <= write_sig[2]      ? writedata[7:0]   : sig[2];
	  sig[3]        <= write_sig[3]      ? writedata[7:0]   : sig[3];
	  sig[4]        <= write_sig[4]      ? writedata[7:0]   : sig[4];
	  sig[5]        <= write_sig[5]      ? writedata[7:0]   : sig[5];
	  sig[6]        <= write_sig[6]      ? writedata[7:0]   : sig[6];
	  sig[7]        <= write_sig[7]      ? writedata[7:0]   : sig[7];
	  sig[8]        <= write_sig[8]      ? writedata[7:0]   : sig[8];
	  sig[9]        <= write_sig[9]      ? writedata[7:0]   : sig[9];
	  sig[10]       <= write_sig[10]     ? writedata[7:0]   : sig[10];
	  sig[11]       <= write_sig[11]     ? writedata[7:0]   : sig[11];
	  sig[12]       <= write_sig[12]     ? writedata[7:0]   : sig[12];
	  sig[13]       <= write_sig[13]     ? writedata[7:0]   : sig[13];
	  sig[14]       <= write_sig[14]     ? writedata[7:0]   : sig[14];
	  sig[15]       <= write_sig[15]     ? writedata[7:0]   : sig[15];
	  sig[16]       <= write_sig[16]     ? writedata[7:0]   : sig[16];
	  sig[17]       <= write_sig[17]     ? writedata[7:0]   : sig[17];
	  sig[18]       <= write_sig[18]     ? writedata[7:0]   : sig[18];
	  sig[19]       <= write_sig[19]     ? writedata[7:0]   : sig[19];
	  sig[20]       <= write_sig[20]     ? writedata[7:0]   : sig[20];
	  sig[21]       <= write_sig[21]     ? writedata[7:0]   : sig[21];
	  sig[22]       <= write_sig[22]     ? writedata[7:0]   : sig[22];
	  sig[23]       <= write_sig[23]     ? writedata[7:0]   : sig[23];
	  sig[24]       <= write_sig[24]     ? writedata[7:0]   : sig[24];
	  sig[25]       <= write_sig[25]     ? writedata[7:0]   : sig[25];
	  sig[26]       <= write_sig[26]     ? writedata[7:0]   : sig[26];
	  sig[27]       <= write_sig[27]     ? writedata[7:0]   : sig[27];
	  sig[28]       <= write_sig[28]     ? writedata[7:0]   : sig[28];
	  sig[29]       <= write_sig[29]     ? writedata[7:0]   : sig[29];
	  sig[30]       <= write_sig[30]     ? writedata[7:0]   : sig[30];
	  sig[31]       <= write_sig[31]     ? writedata[7:0]   : sig[31];
	  sig[32]       <= write_sig[32]     ? writedata[7:0]   : sig[32];
	  sig[33]       <= write_sig[33]     ? writedata[7:0]   : sig[33];
	  sig[34]       <= write_sig[34]     ? writedata[7:0]   : sig[34];
	  sig[35]       <= write_sig[35]     ? writedata[7:0]   : sig[35];
	  sig[36]       <= write_sig[36]     ? writedata[7:0]   : sig[36];
	  sig[37]       <= write_sig[37]     ? writedata[7:0]   : sig[37];
	  sig[38]       <= write_sig[38]     ? writedata[7:0]   : sig[38];
	  sig[39]       <= write_sig[39]     ? writedata[7:0]   : sig[39];
	  sig[40]       <= write_sig[40]     ? writedata[7:0]   : sig[40];
	  sig[41]       <= write_sig[41]     ? writedata[7:0]   : sig[41];
	  sig[42]       <= write_sig[42]     ? writedata[7:0]   : sig[42];
	  sig[43]       <= write_sig[43]     ? writedata[7:0]   : sig[43];
	  sig[44]       <= write_sig[44]     ? writedata[7:0]   : sig[44];
	  sig[45]       <= write_sig[45]     ? writedata[7:0]   : sig[45];
	  sig[46]       <= write_sig[46]     ? writedata[7:0]   : sig[46];
	  sig[47]       <= write_sig[47]     ? writedata[7:0]   : sig[47];
	  sig[48]       <= write_sig[48]     ? writedata[7:0]   : sig[48];
	  sig[49]       <= write_sig[49]     ? writedata[7:0]   : sig[49];
	  sig[50]       <= write_sig[50]     ? writedata[7:0]   : sig[50];
	  sig[51]       <= write_sig[51]     ? writedata[7:0]   : sig[51];
	  sig[52]       <= write_sig[52]     ? writedata[7:0]   : sig[52];
	  sig[53]       <= write_sig[53]     ? writedata[7:0]   : sig[53];
	  sig[54]       <= write_sig[54]     ? writedata[7:0]   : sig[54];
	  sig[55]       <= write_sig[55]     ? writedata[7:0]   : sig[55];
	  sig[56]       <= write_sig[56]     ? writedata[7:0]   : sig[56];
	  sig[57]       <= write_sig[57]     ? writedata[7:0]   : sig[57];
	  sig[58]       <= write_sig[58]     ? writedata[7:0]   : sig[58];
	  sig[59]       <= write_sig[59]     ? writedata[7:0]   : sig[59];
	  sig[60]       <= write_sig[60]     ? writedata[7:0]   : sig[60];
	  sig[61]       <= write_sig[61]     ? writedata[7:0]   : sig[61];
	  sig[62]       <= write_sig[62]     ? writedata[7:0]   : sig[62];
	  sig[63]       <= write_sig[63]     ? writedata[7:0]   : sig[63];
	  sig[64]       <= write_sig[64]     ? writedata[7:0]   : sig[64];
	  sig[65]       <= write_sig[65]     ? writedata[7:0]   : sig[65];
	  sig[66]       <= write_sig[66]     ? writedata[7:0]   : sig[66];
	  sig[67]       <= write_sig[67]     ? writedata[7:0]   : sig[67];
	  sig[68]       <= write_sig[68]     ? writedata[7:0]   : sig[68];
	  sig[69]       <= write_sig[69]     ? writedata[7:0]   : sig[69];
	  sig[70]       <= write_sig[70]     ? writedata[7:0]   : sig[70];
	  sig[71]       <= write_sig[71]     ? writedata[7:0]   : sig[71];
	  sig[72]       <= write_sig[72]     ? writedata[7:0]   : sig[72];
	  sig[73]       <= write_sig[73]     ? writedata[7:0]   : sig[73];
	  sig[74]       <= write_sig[74]     ? writedata[7:0]   : sig[74];
	  sig[75]       <= write_sig[75]     ? writedata[7:0]   : sig[75];
	  sig[76]       <= write_sig[76]     ? writedata[7:0]   : sig[76];
	  sig[77]       <= write_sig[77]     ? writedata[7:0]   : sig[77];
	  sig[78]       <= write_sig[78]     ? writedata[7:0]   : sig[78];
	  sig[79]       <= write_sig[79]     ? writedata[7:0]   : sig[79];
	  sig[80]       <= write_sig[80]     ? writedata[7:0]   : sig[80];
	  sig[81]       <= write_sig[81]     ? writedata[7:0]   : sig[81];
	  sig[82]       <= write_sig[82]     ? writedata[7:0]   : sig[82];
	  sig[83]       <= write_sig[83]     ? writedata[7:0]   : sig[83];
	  sig[84]       <= write_sig[84]     ? writedata[7:0]   : sig[84];
	  sig[85]       <= write_sig[85]     ? writedata[7:0]   : sig[85];
	  sig[86]       <= write_sig[86]     ? writedata[7:0]   : sig[86];
	  sig[87]       <= write_sig[87]     ? writedata[7:0]   : sig[87];
	  sig[88]       <= write_sig[88]     ? writedata[7:0]   : sig[88];
	  sig[89]       <= write_sig[89]     ? writedata[7:0]   : sig[89];
	  sig[90]       <= write_sig[90]     ? writedata[7:0]   : sig[90];
	  sig[91]       <= write_sig[91]     ? writedata[7:0]   : sig[91];
	  sig[92]       <= write_sig[92]     ? writedata[7:0]   : sig[92];
	  sig[93]       <= write_sig[93]     ? writedata[7:0]   : sig[93];
	  sig[94]       <= write_sig[94]     ? writedata[7:0]   : sig[94];
	  sig[95]       <= write_sig[95]     ? writedata[7:0]   : sig[95];
	  sig[96]       <= write_sig[96]     ? writedata[7:0]   : sig[96];
	  sig[97]       <= write_sig[97]     ? writedata[7:0]   : sig[97];
	  sig[98]       <= write_sig[98]     ? writedata[7:0]   : sig[98];
	  sig[99]       <= write_sig[99]     ? writedata[7:0]   : sig[99];
	  sig[100]      <= write_sig[100]    ? writedata[7:0]   : sig[100];
	  sig[101]      <= write_sig[101]    ? writedata[7:0]   : sig[101];
	  sig[102]      <= write_sig[102]    ? writedata[7:0]   : sig[102];
	  sig[103]      <= write_sig[103]    ? writedata[7:0]   : sig[103];
	  sig[104]      <= write_sig[104]    ? writedata[7:0]   : sig[104];
	  sig[105]      <= write_sig[105]    ? writedata[7:0]   : sig[105];
	  sig[106]      <= write_sig[106]    ? writedata[7:0]   : sig[106];
	  sig[107]      <= write_sig[107]    ? writedata[7:0]   : sig[107];
	  sig[108]      <= write_sig[108]    ? writedata[7:0]   : sig[108];
	  sig[109]      <= write_sig[109]    ? writedata[7:0]   : sig[109];
	  sig[110]      <= write_sig[110]    ? writedata[7:0]   : sig[110];
	  sig[111]      <= write_sig[111]    ? writedata[7:0]   : sig[111];
	  sig[112]      <= write_sig[112]    ? writedata[7:0]   : sig[112];
	  sig[113]      <= write_sig[113]    ? writedata[7:0]   : sig[113];
	  sig[114]      <= write_sig[114]    ? writedata[7:0]   : sig[114];
	  sig[115]      <= write_sig[115]    ? writedata[7:0]   : sig[115];
	  sig[116]      <= write_sig[116]    ? writedata[7:0]   : sig[116];
	  sig[117]      <= write_sig[117]    ? writedata[7:0]   : sig[117];
	  sig[118]      <= write_sig[118]    ? writedata[7:0]   : sig[118];
	  sig[119]      <= write_sig[119]    ? writedata[7:0]   : sig[119];
	  sig[120]      <= write_sig[120]    ? writedata[7:0]   : sig[120];
	  sig[121]      <= write_sig[121]    ? writedata[7:0]   : sig[121];
	  sig[122]      <= write_sig[122]    ? writedata[7:0]   : sig[122];
	  sig[123]      <= write_sig[123]    ? writedata[7:0]   : sig[123];
	  sig[124]      <= write_sig[124]    ? writedata[7:0]   : sig[124];
	  sig[125]      <= write_sig[125]    ? writedata[7:0]   : sig[125];
	  sig[126]      <= write_sig[126]    ? writedata[7:0]   : sig[126];
	  sig[127]      <= write_sig[127]    ? writedata[7:0]   : sig[127];
	  j				<= write_jloop		 ? writedata[8:0]	: j;
   	  acc			<= write_retval 	 ? sum   		 	: acc;
	  hw_ctl        <= write_ctl    	 ? writedata[0]     : hw_ctl;
	  hw_ctl_old    <= hw_ctl;
       // end

	
// always@(j)
case(j)
	1 :begin
result[0] = template[0] * sig[0];
result[1] = template[1] * sig[1];
result[2] = template[2] * sig[2];
result[3] = template[3] * sig[3];
result[4] = template[4] * sig[4];
result[5] = template[5] * sig[5];
result[6] = template[6] * sig[6];
result[7] = template[7] * sig[7];
result[8] = template[8] * sig[8];
result[9] = template[9] * sig[9];
result[10] = template[10] * sig[10];
result[11] = template[11] * sig[11];
result[12] = template[12] * sig[12];
result[13] = template[13] * sig[13];
result[14] = template[14] * sig[14];
result[15] = template[15] * sig[15];
end
2 :begin
result[0] = template[0] * sig[1];
result[1] = template[1] * sig[2];
result[2] = template[2] * sig[3];
result[3] = template[3] * sig[4];
result[4] = template[4] * sig[5];
result[5] = template[5] * sig[6];
result[6] = template[6] * sig[7];
result[7] = template[7] * sig[8];
result[8] = template[8] * sig[9];
result[9] = template[9] * sig[10];
result[10] = template[10] * sig[11];
result[11] = template[11] * sig[12];
result[12] = template[12] * sig[13];
result[13] = template[13] * sig[14];
result[14] = template[14] * sig[15];
result[15] = template[15] * sig[16];
end
3 :begin
result[0] = template[0] * sig[2];
result[1] = template[1] * sig[3];
result[2] = template[2] * sig[4];
result[3] = template[3] * sig[5];
result[4] = template[4] * sig[6];
result[5] = template[5] * sig[7];
result[6] = template[6] * sig[8];
result[7] = template[7] * sig[9];
result[8] = template[8] * sig[10];
result[9] = template[9] * sig[11];
result[10] = template[10] * sig[12];
result[11] = template[11] * sig[13];
result[12] = template[12] * sig[14];
result[13] = template[13] * sig[15];
result[14] = template[14] * sig[16];
result[15] = template[15] * sig[17];
end
4 :begin
result[0] = template[0] * sig[3];
result[1] = template[1] * sig[4];
result[2] = template[2] * sig[5];
result[3] = template[3] * sig[6];
result[4] = template[4] * sig[7];
result[5] = template[5] * sig[8];
result[6] = template[6] * sig[9];
result[7] = template[7] * sig[10];
result[8] = template[8] * sig[11];
result[9] = template[9] * sig[12];
result[10] = template[10] * sig[13];
result[11] = template[11] * sig[14];
result[12] = template[12] * sig[15];
result[13] = template[13] * sig[16];
result[14] = template[14] * sig[17];
result[15] = template[15] * sig[18];
end
5 :begin
result[0] = template[0] * sig[4];
result[1] = template[1] * sig[5];
result[2] = template[2] * sig[6];
result[3] = template[3] * sig[7];
result[4] = template[4] * sig[8];
result[5] = template[5] * sig[9];
result[6] = template[6] * sig[10];
result[7] = template[7] * sig[11];
result[8] = template[8] * sig[12];
result[9] = template[9] * sig[13];
result[10] = template[10] * sig[14];
result[11] = template[11] * sig[15];
result[12] = template[12] * sig[16];
result[13] = template[13] * sig[17];
result[14] = template[14] * sig[18];
result[15] = template[15] * sig[19];
end
6 :begin
result[0] = template[0] * sig[5];
result[1] = template[1] * sig[6];
result[2] = template[2] * sig[7];
result[3] = template[3] * sig[8];
result[4] = template[4] * sig[9];
result[5] = template[5] * sig[10];
result[6] = template[6] * sig[11];
result[7] = template[7] * sig[12];
result[8] = template[8] * sig[13];
result[9] = template[9] * sig[14];
result[10] = template[10] * sig[15];
result[11] = template[11] * sig[16];
result[12] = template[12] * sig[17];
result[13] = template[13] * sig[18];
result[14] = template[14] * sig[19];
result[15] = template[15] * sig[20];
end
7 :begin
result[0] = template[0] * sig[6];
result[1] = template[1] * sig[7];
result[2] = template[2] * sig[8];
result[3] = template[3] * sig[9];
result[4] = template[4] * sig[10];
result[5] = template[5] * sig[11];
result[6] = template[6] * sig[12];
result[7] = template[7] * sig[13];
result[8] = template[8] * sig[14];
result[9] = template[9] * sig[15];
result[10] = template[10] * sig[16];
result[11] = template[11] * sig[17];
result[12] = template[12] * sig[18];
result[13] = template[13] * sig[19];
result[14] = template[14] * sig[20];
result[15] = template[15] * sig[21];
end
8 :begin
result[0] = template[0] * sig[7];
result[1] = template[1] * sig[8];
result[2] = template[2] * sig[9];
result[3] = template[3] * sig[10];
result[4] = template[4] * sig[11];
result[5] = template[5] * sig[12];
result[6] = template[6] * sig[13];
result[7] = template[7] * sig[14];
result[8] = template[8] * sig[15];
result[9] = template[9] * sig[16];
result[10] = template[10] * sig[17];
result[11] = template[11] * sig[18];
result[12] = template[12] * sig[19];
result[13] = template[13] * sig[20];
result[14] = template[14] * sig[21];
result[15] = template[15] * sig[22];
end
9 :begin
result[0] = template[0] * sig[8];
result[1] = template[1] * sig[9];
result[2] = template[2] * sig[10];
result[3] = template[3] * sig[11];
result[4] = template[4] * sig[12];
result[5] = template[5] * sig[13];
result[6] = template[6] * sig[14];
result[7] = template[7] * sig[15];
result[8] = template[8] * sig[16];
result[9] = template[9] * sig[17];
result[10] = template[10] * sig[18];
result[11] = template[11] * sig[19];
result[12] = template[12] * sig[20];
result[13] = template[13] * sig[21];
result[14] = template[14] * sig[22];
result[15] = template[15] * sig[23];
end
10 :begin
result[0] = template[0] * sig[9];
result[1] = template[1] * sig[10];
result[2] = template[2] * sig[11];
result[3] = template[3] * sig[12];
result[4] = template[4] * sig[13];
result[5] = template[5] * sig[14];
result[6] = template[6] * sig[15];
result[7] = template[7] * sig[16];
result[8] = template[8] * sig[17];
result[9] = template[9] * sig[18];
result[10] = template[10] * sig[19];
result[11] = template[11] * sig[20];
result[12] = template[12] * sig[21];
result[13] = template[13] * sig[22];
result[14] = template[14] * sig[23];
result[15] = template[15] * sig[24];
end
11 :begin
result[0] = template[0] * sig[10];
result[1] = template[1] * sig[11];
result[2] = template[2] * sig[12];
result[3] = template[3] * sig[13];
result[4] = template[4] * sig[14];
result[5] = template[5] * sig[15];
result[6] = template[6] * sig[16];
result[7] = template[7] * sig[17];
result[8] = template[8] * sig[18];
result[9] = template[9] * sig[19];
result[10] = template[10] * sig[20];
result[11] = template[11] * sig[21];
result[12] = template[12] * sig[22];
result[13] = template[13] * sig[23];
result[14] = template[14] * sig[24];
result[15] = template[15] * sig[25];
end
12 :begin
result[0] = template[0] * sig[11];
result[1] = template[1] * sig[12];
result[2] = template[2] * sig[13];
result[3] = template[3] * sig[14];
result[4] = template[4] * sig[15];
result[5] = template[5] * sig[16];
result[6] = template[6] * sig[17];
result[7] = template[7] * sig[18];
result[8] = template[8] * sig[19];
result[9] = template[9] * sig[20];
result[10] = template[10] * sig[21];
result[11] = template[11] * sig[22];
result[12] = template[12] * sig[23];
result[13] = template[13] * sig[24];
result[14] = template[14] * sig[25];
result[15] = template[15] * sig[26];
end
13 :begin
result[0] = template[0] * sig[12];
result[1] = template[1] * sig[13];
result[2] = template[2] * sig[14];
result[3] = template[3] * sig[15];
result[4] = template[4] * sig[16];
result[5] = template[5] * sig[17];
result[6] = template[6] * sig[18];
result[7] = template[7] * sig[19];
result[8] = template[8] * sig[20];
result[9] = template[9] * sig[21];
result[10] = template[10] * sig[22];
result[11] = template[11] * sig[23];
result[12] = template[12] * sig[24];
result[13] = template[13] * sig[25];
result[14] = template[14] * sig[26];
result[15] = template[15] * sig[27];
end
14 :begin
result[0] = template[0] * sig[13];
result[1] = template[1] * sig[14];
result[2] = template[2] * sig[15];
result[3] = template[3] * sig[16];
result[4] = template[4] * sig[17];
result[5] = template[5] * sig[18];
result[6] = template[6] * sig[19];
result[7] = template[7] * sig[20];
result[8] = template[8] * sig[21];
result[9] = template[9] * sig[22];
result[10] = template[10] * sig[23];
result[11] = template[11] * sig[24];
result[12] = template[12] * sig[25];
result[13] = template[13] * sig[26];
result[14] = template[14] * sig[27];
result[15] = template[15] * sig[28];
end
15 :begin
result[0] = template[0] * sig[14];
result[1] = template[1] * sig[15];
result[2] = template[2] * sig[16];
result[3] = template[3] * sig[17];
result[4] = template[4] * sig[18];
result[5] = template[5] * sig[19];
result[6] = template[6] * sig[20];
result[7] = template[7] * sig[21];
result[8] = template[8] * sig[22];
result[9] = template[9] * sig[23];
result[10] = template[10] * sig[24];
result[11] = template[11] * sig[25];
result[12] = template[12] * sig[26];
result[13] = template[13] * sig[27];
result[14] = template[14] * sig[28];
result[15] = template[15] * sig[29];
end
16 :begin
result[0] = template[0] * sig[15];
result[1] = template[1] * sig[16];
result[2] = template[2] * sig[17];
result[3] = template[3] * sig[18];
result[4] = template[4] * sig[19];
result[5] = template[5] * sig[20];
result[6] = template[6] * sig[21];
result[7] = template[7] * sig[22];
result[8] = template[8] * sig[23];
result[9] = template[9] * sig[24];
result[10] = template[10] * sig[25];
result[11] = template[11] * sig[26];
result[12] = template[12] * sig[27];
result[13] = template[13] * sig[28];
result[14] = template[14] * sig[29];
result[15] = template[15] * sig[30];
end
17 :begin
result[0] = template[0] * sig[16];
result[1] = template[1] * sig[17];
result[2] = template[2] * sig[18];
result[3] = template[3] * sig[19];
result[4] = template[4] * sig[20];
result[5] = template[5] * sig[21];
result[6] = template[6] * sig[22];
result[7] = template[7] * sig[23];
result[8] = template[8] * sig[24];
result[9] = template[9] * sig[25];
result[10] = template[10] * sig[26];
result[11] = template[11] * sig[27];
result[12] = template[12] * sig[28];
result[13] = template[13] * sig[29];
result[14] = template[14] * sig[30];
result[15] = template[15] * sig[31];
end
18 :begin
result[0] = template[0] * sig[17];
result[1] = template[1] * sig[18];
result[2] = template[2] * sig[19];
result[3] = template[3] * sig[20];
result[4] = template[4] * sig[21];
result[5] = template[5] * sig[22];
result[6] = template[6] * sig[23];
result[7] = template[7] * sig[24];
result[8] = template[8] * sig[25];
result[9] = template[9] * sig[26];
result[10] = template[10] * sig[27];
result[11] = template[11] * sig[28];
result[12] = template[12] * sig[29];
result[13] = template[13] * sig[30];
result[14] = template[14] * sig[31];
result[15] = template[15] * sig[32];
end
19 :begin
result[0] = template[0] * sig[18];
result[1] = template[1] * sig[19];
result[2] = template[2] * sig[20];
result[3] = template[3] * sig[21];
result[4] = template[4] * sig[22];
result[5] = template[5] * sig[23];
result[6] = template[6] * sig[24];
result[7] = template[7] * sig[25];
result[8] = template[8] * sig[26];
result[9] = template[9] * sig[27];
result[10] = template[10] * sig[28];
result[11] = template[11] * sig[29];
result[12] = template[12] * sig[30];
result[13] = template[13] * sig[31];
result[14] = template[14] * sig[32];
result[15] = template[15] * sig[33];
end
20 :begin
result[0] = template[0] * sig[19];
result[1] = template[1] * sig[20];
result[2] = template[2] * sig[21];
result[3] = template[3] * sig[22];
result[4] = template[4] * sig[23];
result[5] = template[5] * sig[24];
result[6] = template[6] * sig[25];
result[7] = template[7] * sig[26];
result[8] = template[8] * sig[27];
result[9] = template[9] * sig[28];
result[10] = template[10] * sig[29];
result[11] = template[11] * sig[30];
result[12] = template[12] * sig[31];
result[13] = template[13] * sig[32];
result[14] = template[14] * sig[33];
result[15] = template[15] * sig[34];
end
21 :begin
result[0] = template[0] * sig[20];
result[1] = template[1] * sig[21];
result[2] = template[2] * sig[22];
result[3] = template[3] * sig[23];
result[4] = template[4] * sig[24];
result[5] = template[5] * sig[25];
result[6] = template[6] * sig[26];
result[7] = template[7] * sig[27];
result[8] = template[8] * sig[28];
result[9] = template[9] * sig[29];
result[10] = template[10] * sig[30];
result[11] = template[11] * sig[31];
result[12] = template[12] * sig[32];
result[13] = template[13] * sig[33];
result[14] = template[14] * sig[34];
result[15] = template[15] * sig[35];
end
22 :begin
result[0] = template[0] * sig[21];
result[1] = template[1] * sig[22];
result[2] = template[2] * sig[23];
result[3] = template[3] * sig[24];
result[4] = template[4] * sig[25];
result[5] = template[5] * sig[26];
result[6] = template[6] * sig[27];
result[7] = template[7] * sig[28];
result[8] = template[8] * sig[29];
result[9] = template[9] * sig[30];
result[10] = template[10] * sig[31];
result[11] = template[11] * sig[32];
result[12] = template[12] * sig[33];
result[13] = template[13] * sig[34];
result[14] = template[14] * sig[35];
result[15] = template[15] * sig[36];
end
23 :begin
result[0] = template[0] * sig[22];
result[1] = template[1] * sig[23];
result[2] = template[2] * sig[24];
result[3] = template[3] * sig[25];
result[4] = template[4] * sig[26];
result[5] = template[5] * sig[27];
result[6] = template[6] * sig[28];
result[7] = template[7] * sig[29];
result[8] = template[8] * sig[30];
result[9] = template[9] * sig[31];
result[10] = template[10] * sig[32];
result[11] = template[11] * sig[33];
result[12] = template[12] * sig[34];
result[13] = template[13] * sig[35];
result[14] = template[14] * sig[36];
result[15] = template[15] * sig[37];
end
24 :begin
result[0] = template[0] * sig[23];
result[1] = template[1] * sig[24];
result[2] = template[2] * sig[25];
result[3] = template[3] * sig[26];
result[4] = template[4] * sig[27];
result[5] = template[5] * sig[28];
result[6] = template[6] * sig[29];
result[7] = template[7] * sig[30];
result[8] = template[8] * sig[31];
result[9] = template[9] * sig[32];
result[10] = template[10] * sig[33];
result[11] = template[11] * sig[34];
result[12] = template[12] * sig[35];
result[13] = template[13] * sig[36];
result[14] = template[14] * sig[37];
result[15] = template[15] * sig[38];
end
25 :begin
result[0] = template[0] * sig[24];
result[1] = template[1] * sig[25];
result[2] = template[2] * sig[26];
result[3] = template[3] * sig[27];
result[4] = template[4] * sig[28];
result[5] = template[5] * sig[29];
result[6] = template[6] * sig[30];
result[7] = template[7] * sig[31];
result[8] = template[8] * sig[32];
result[9] = template[9] * sig[33];
result[10] = template[10] * sig[34];
result[11] = template[11] * sig[35];
result[12] = template[12] * sig[36];
result[13] = template[13] * sig[37];
result[14] = template[14] * sig[38];
result[15] = template[15] * sig[39];
end
26 :begin
result[0] = template[0] * sig[25];
result[1] = template[1] * sig[26];
result[2] = template[2] * sig[27];
result[3] = template[3] * sig[28];
result[4] = template[4] * sig[29];
result[5] = template[5] * sig[30];
result[6] = template[6] * sig[31];
result[7] = template[7] * sig[32];
result[8] = template[8] * sig[33];
result[9] = template[9] * sig[34];
result[10] = template[10] * sig[35];
result[11] = template[11] * sig[36];
result[12] = template[12] * sig[37];
result[13] = template[13] * sig[38];
result[14] = template[14] * sig[39];
result[15] = template[15] * sig[40];
end
27 :begin
result[0] = template[0] * sig[26];
result[1] = template[1] * sig[27];
result[2] = template[2] * sig[28];
result[3] = template[3] * sig[29];
result[4] = template[4] * sig[30];
result[5] = template[5] * sig[31];
result[6] = template[6] * sig[32];
result[7] = template[7] * sig[33];
result[8] = template[8] * sig[34];
result[9] = template[9] * sig[35];
result[10] = template[10] * sig[36];
result[11] = template[11] * sig[37];
result[12] = template[12] * sig[38];
result[13] = template[13] * sig[39];
result[14] = template[14] * sig[40];
result[15] = template[15] * sig[41];
end
28 :begin
result[0] = template[0] * sig[27];
result[1] = template[1] * sig[28];
result[2] = template[2] * sig[29];
result[3] = template[3] * sig[30];
result[4] = template[4] * sig[31];
result[5] = template[5] * sig[32];
result[6] = template[6] * sig[33];
result[7] = template[7] * sig[34];
result[8] = template[8] * sig[35];
result[9] = template[9] * sig[36];
result[10] = template[10] * sig[37];
result[11] = template[11] * sig[38];
result[12] = template[12] * sig[39];
result[13] = template[13] * sig[40];
result[14] = template[14] * sig[41];
result[15] = template[15] * sig[42];
end
29 :begin
result[0] = template[0] * sig[28];
result[1] = template[1] * sig[29];
result[2] = template[2] * sig[30];
result[3] = template[3] * sig[31];
result[4] = template[4] * sig[32];
result[5] = template[5] * sig[33];
result[6] = template[6] * sig[34];
result[7] = template[7] * sig[35];
result[8] = template[8] * sig[36];
result[9] = template[9] * sig[37];
result[10] = template[10] * sig[38];
result[11] = template[11] * sig[39];
result[12] = template[12] * sig[40];
result[13] = template[13] * sig[41];
result[14] = template[14] * sig[42];
result[15] = template[15] * sig[43];
end
30 :begin
result[0] = template[0] * sig[29];
result[1] = template[1] * sig[30];
result[2] = template[2] * sig[31];
result[3] = template[3] * sig[32];
result[4] = template[4] * sig[33];
result[5] = template[5] * sig[34];
result[6] = template[6] * sig[35];
result[7] = template[7] * sig[36];
result[8] = template[8] * sig[37];
result[9] = template[9] * sig[38];
result[10] = template[10] * sig[39];
result[11] = template[11] * sig[40];
result[12] = template[12] * sig[41];
result[13] = template[13] * sig[42];
result[14] = template[14] * sig[43];
result[15] = template[15] * sig[44];
end
31 :begin
result[0] = template[0] * sig[30];
result[1] = template[1] * sig[31];
result[2] = template[2] * sig[32];
result[3] = template[3] * sig[33];
result[4] = template[4] * sig[34];
result[5] = template[5] * sig[35];
result[6] = template[6] * sig[36];
result[7] = template[7] * sig[37];
result[8] = template[8] * sig[38];
result[9] = template[9] * sig[39];
result[10] = template[10] * sig[40];
result[11] = template[11] * sig[41];
result[12] = template[12] * sig[42];
result[13] = template[13] * sig[43];
result[14] = template[14] * sig[44];
result[15] = template[15] * sig[45];
end
32 :begin
result[0] = template[0] * sig[31];
result[1] = template[1] * sig[32];
result[2] = template[2] * sig[33];
result[3] = template[3] * sig[34];
result[4] = template[4] * sig[35];
result[5] = template[5] * sig[36];
result[6] = template[6] * sig[37];
result[7] = template[7] * sig[38];
result[8] = template[8] * sig[39];
result[9] = template[9] * sig[40];
result[10] = template[10] * sig[41];
result[11] = template[11] * sig[42];
result[12] = template[12] * sig[43];
result[13] = template[13] * sig[44];
result[14] = template[14] * sig[45];
result[15] = template[15] * sig[46];
end
33 :begin
result[0] = template[0] * sig[32];
result[1] = template[1] * sig[33];
result[2] = template[2] * sig[34];
result[3] = template[3] * sig[35];
result[4] = template[4] * sig[36];
result[5] = template[5] * sig[37];
result[6] = template[6] * sig[38];
result[7] = template[7] * sig[39];
result[8] = template[8] * sig[40];
result[9] = template[9] * sig[41];
result[10] = template[10] * sig[42];
result[11] = template[11] * sig[43];
result[12] = template[12] * sig[44];
result[13] = template[13] * sig[45];
result[14] = template[14] * sig[46];
result[15] = template[15] * sig[47];
end
34 :begin
result[0] = template[0] * sig[33];
result[1] = template[1] * sig[34];
result[2] = template[2] * sig[35];
result[3] = template[3] * sig[36];
result[4] = template[4] * sig[37];
result[5] = template[5] * sig[38];
result[6] = template[6] * sig[39];
result[7] = template[7] * sig[40];
result[8] = template[8] * sig[41];
result[9] = template[9] * sig[42];
result[10] = template[10] * sig[43];
result[11] = template[11] * sig[44];
result[12] = template[12] * sig[45];
result[13] = template[13] * sig[46];
result[14] = template[14] * sig[47];
result[15] = template[15] * sig[48];
end
35 :begin
result[0] = template[0] * sig[34];
result[1] = template[1] * sig[35];
result[2] = template[2] * sig[36];
result[3] = template[3] * sig[37];
result[4] = template[4] * sig[38];
result[5] = template[5] * sig[39];
result[6] = template[6] * sig[40];
result[7] = template[7] * sig[41];
result[8] = template[8] * sig[42];
result[9] = template[9] * sig[43];
result[10] = template[10] * sig[44];
result[11] = template[11] * sig[45];
result[12] = template[12] * sig[46];
result[13] = template[13] * sig[47];
result[14] = template[14] * sig[48];
result[15] = template[15] * sig[49];
end
36 :begin
result[0] = template[0] * sig[35];
result[1] = template[1] * sig[36];
result[2] = template[2] * sig[37];
result[3] = template[3] * sig[38];
result[4] = template[4] * sig[39];
result[5] = template[5] * sig[40];
result[6] = template[6] * sig[41];
result[7] = template[7] * sig[42];
result[8] = template[8] * sig[43];
result[9] = template[9] * sig[44];
result[10] = template[10] * sig[45];
result[11] = template[11] * sig[46];
result[12] = template[12] * sig[47];
result[13] = template[13] * sig[48];
result[14] = template[14] * sig[49];
result[15] = template[15] * sig[50];
end
37 :begin
result[0] = template[0] * sig[36];
result[1] = template[1] * sig[37];
result[2] = template[2] * sig[38];
result[3] = template[3] * sig[39];
result[4] = template[4] * sig[40];
result[5] = template[5] * sig[41];
result[6] = template[6] * sig[42];
result[7] = template[7] * sig[43];
result[8] = template[8] * sig[44];
result[9] = template[9] * sig[45];
result[10] = template[10] * sig[46];
result[11] = template[11] * sig[47];
result[12] = template[12] * sig[48];
result[13] = template[13] * sig[49];
result[14] = template[14] * sig[50];
result[15] = template[15] * sig[51];
end
38 :begin
result[0] = template[0] * sig[37];
result[1] = template[1] * sig[38];
result[2] = template[2] * sig[39];
result[3] = template[3] * sig[40];
result[4] = template[4] * sig[41];
result[5] = template[5] * sig[42];
result[6] = template[6] * sig[43];
result[7] = template[7] * sig[44];
result[8] = template[8] * sig[45];
result[9] = template[9] * sig[46];
result[10] = template[10] * sig[47];
result[11] = template[11] * sig[48];
result[12] = template[12] * sig[49];
result[13] = template[13] * sig[50];
result[14] = template[14] * sig[51];
result[15] = template[15] * sig[52];
end
39 :begin
result[0] = template[0] * sig[38];
result[1] = template[1] * sig[39];
result[2] = template[2] * sig[40];
result[3] = template[3] * sig[41];
result[4] = template[4] * sig[42];
result[5] = template[5] * sig[43];
result[6] = template[6] * sig[44];
result[7] = template[7] * sig[45];
result[8] = template[8] * sig[46];
result[9] = template[9] * sig[47];
result[10] = template[10] * sig[48];
result[11] = template[11] * sig[49];
result[12] = template[12] * sig[50];
result[13] = template[13] * sig[51];
result[14] = template[14] * sig[52];
result[15] = template[15] * sig[53];
end
40 :begin
result[0] = template[0] * sig[39];
result[1] = template[1] * sig[40];
result[2] = template[2] * sig[41];
result[3] = template[3] * sig[42];
result[4] = template[4] * sig[43];
result[5] = template[5] * sig[44];
result[6] = template[6] * sig[45];
result[7] = template[7] * sig[46];
result[8] = template[8] * sig[47];
result[9] = template[9] * sig[48];
result[10] = template[10] * sig[49];
result[11] = template[11] * sig[50];
result[12] = template[12] * sig[51];
result[13] = template[13] * sig[52];
result[14] = template[14] * sig[53];
result[15] = template[15] * sig[54];
end
41 :begin
result[0] = template[0] * sig[40];
result[1] = template[1] * sig[41];
result[2] = template[2] * sig[42];
result[3] = template[3] * sig[43];
result[4] = template[4] * sig[44];
result[5] = template[5] * sig[45];
result[6] = template[6] * sig[46];
result[7] = template[7] * sig[47];
result[8] = template[8] * sig[48];
result[9] = template[9] * sig[49];
result[10] = template[10] * sig[50];
result[11] = template[11] * sig[51];
result[12] = template[12] * sig[52];
result[13] = template[13] * sig[53];
result[14] = template[14] * sig[54];
result[15] = template[15] * sig[55];
end
42 :begin
result[0] = template[0] * sig[41];
result[1] = template[1] * sig[42];
result[2] = template[2] * sig[43];
result[3] = template[3] * sig[44];
result[4] = template[4] * sig[45];
result[5] = template[5] * sig[46];
result[6] = template[6] * sig[47];
result[7] = template[7] * sig[48];
result[8] = template[8] * sig[49];
result[9] = template[9] * sig[50];
result[10] = template[10] * sig[51];
result[11] = template[11] * sig[52];
result[12] = template[12] * sig[53];
result[13] = template[13] * sig[54];
result[14] = template[14] * sig[55];
result[15] = template[15] * sig[56];
end
43 :begin
result[0] = template[0] * sig[42];
result[1] = template[1] * sig[43];
result[2] = template[2] * sig[44];
result[3] = template[3] * sig[45];
result[4] = template[4] * sig[46];
result[5] = template[5] * sig[47];
result[6] = template[6] * sig[48];
result[7] = template[7] * sig[49];
result[8] = template[8] * sig[50];
result[9] = template[9] * sig[51];
result[10] = template[10] * sig[52];
result[11] = template[11] * sig[53];
result[12] = template[12] * sig[54];
result[13] = template[13] * sig[55];
result[14] = template[14] * sig[56];
result[15] = template[15] * sig[57];
end
44 :begin
result[0] = template[0] * sig[43];
result[1] = template[1] * sig[44];
result[2] = template[2] * sig[45];
result[3] = template[3] * sig[46];
result[4] = template[4] * sig[47];
result[5] = template[5] * sig[48];
result[6] = template[6] * sig[49];
result[7] = template[7] * sig[50];
result[8] = template[8] * sig[51];
result[9] = template[9] * sig[52];
result[10] = template[10] * sig[53];
result[11] = template[11] * sig[54];
result[12] = template[12] * sig[55];
result[13] = template[13] * sig[56];
result[14] = template[14] * sig[57];
result[15] = template[15] * sig[58];
end
45 :begin
result[0] = template[0] * sig[44];
result[1] = template[1] * sig[45];
result[2] = template[2] * sig[46];
result[3] = template[3] * sig[47];
result[4] = template[4] * sig[48];
result[5] = template[5] * sig[49];
result[6] = template[6] * sig[50];
result[7] = template[7] * sig[51];
result[8] = template[8] * sig[52];
result[9] = template[9] * sig[53];
result[10] = template[10] * sig[54];
result[11] = template[11] * sig[55];
result[12] = template[12] * sig[56];
result[13] = template[13] * sig[57];
result[14] = template[14] * sig[58];
result[15] = template[15] * sig[59];
end
46 :begin
result[0] = template[0] * sig[45];
result[1] = template[1] * sig[46];
result[2] = template[2] * sig[47];
result[3] = template[3] * sig[48];
result[4] = template[4] * sig[49];
result[5] = template[5] * sig[50];
result[6] = template[6] * sig[51];
result[7] = template[7] * sig[52];
result[8] = template[8] * sig[53];
result[9] = template[9] * sig[54];
result[10] = template[10] * sig[55];
result[11] = template[11] * sig[56];
result[12] = template[12] * sig[57];
result[13] = template[13] * sig[58];
result[14] = template[14] * sig[59];
result[15] = template[15] * sig[60];
end
47 :begin
result[0] = template[0] * sig[46];
result[1] = template[1] * sig[47];
result[2] = template[2] * sig[48];
result[3] = template[3] * sig[49];
result[4] = template[4] * sig[50];
result[5] = template[5] * sig[51];
result[6] = template[6] * sig[52];
result[7] = template[7] * sig[53];
result[8] = template[8] * sig[54];
result[9] = template[9] * sig[55];
result[10] = template[10] * sig[56];
result[11] = template[11] * sig[57];
result[12] = template[12] * sig[58];
result[13] = template[13] * sig[59];
result[14] = template[14] * sig[60];
result[15] = template[15] * sig[61];
end
48 :begin
result[0] = template[0] * sig[47];
result[1] = template[1] * sig[48];
result[2] = template[2] * sig[49];
result[3] = template[3] * sig[50];
result[4] = template[4] * sig[51];
result[5] = template[5] * sig[52];
result[6] = template[6] * sig[53];
result[7] = template[7] * sig[54];
result[8] = template[8] * sig[55];
result[9] = template[9] * sig[56];
result[10] = template[10] * sig[57];
result[11] = template[11] * sig[58];
result[12] = template[12] * sig[59];
result[13] = template[13] * sig[60];
result[14] = template[14] * sig[61];
result[15] = template[15] * sig[62];
end
49 :begin
result[0] = template[0] * sig[48];
result[1] = template[1] * sig[49];
result[2] = template[2] * sig[50];
result[3] = template[3] * sig[51];
result[4] = template[4] * sig[52];
result[5] = template[5] * sig[53];
result[6] = template[6] * sig[54];
result[7] = template[7] * sig[55];
result[8] = template[8] * sig[56];
result[9] = template[9] * sig[57];
result[10] = template[10] * sig[58];
result[11] = template[11] * sig[59];
result[12] = template[12] * sig[60];
result[13] = template[13] * sig[61];
result[14] = template[14] * sig[62];
result[15] = template[15] * sig[63];
end
50 :begin
result[0] = template[0] * sig[49];
result[1] = template[1] * sig[50];
result[2] = template[2] * sig[51];
result[3] = template[3] * sig[52];
result[4] = template[4] * sig[53];
result[5] = template[5] * sig[54];
result[6] = template[6] * sig[55];
result[7] = template[7] * sig[56];
result[8] = template[8] * sig[57];
result[9] = template[9] * sig[58];
result[10] = template[10] * sig[59];
result[11] = template[11] * sig[60];
result[12] = template[12] * sig[61];
result[13] = template[13] * sig[62];
result[14] = template[14] * sig[63];
result[15] = template[15] * sig[64];
end
51 :begin
result[0] = template[0] * sig[50];
result[1] = template[1] * sig[51];
result[2] = template[2] * sig[52];
result[3] = template[3] * sig[53];
result[4] = template[4] * sig[54];
result[5] = template[5] * sig[55];
result[6] = template[6] * sig[56];
result[7] = template[7] * sig[57];
result[8] = template[8] * sig[58];
result[9] = template[9] * sig[59];
result[10] = template[10] * sig[60];
result[11] = template[11] * sig[61];
result[12] = template[12] * sig[62];
result[13] = template[13] * sig[63];
result[14] = template[14] * sig[64];
result[15] = template[15] * sig[65];
end
52 :begin
result[0] = template[0] * sig[51];
result[1] = template[1] * sig[52];
result[2] = template[2] * sig[53];
result[3] = template[3] * sig[54];
result[4] = template[4] * sig[55];
result[5] = template[5] * sig[56];
result[6] = template[6] * sig[57];
result[7] = template[7] * sig[58];
result[8] = template[8] * sig[59];
result[9] = template[9] * sig[60];
result[10] = template[10] * sig[61];
result[11] = template[11] * sig[62];
result[12] = template[12] * sig[63];
result[13] = template[13] * sig[64];
result[14] = template[14] * sig[65];
result[15] = template[15] * sig[66];
end
53 :begin
result[0] = template[0] * sig[52];
result[1] = template[1] * sig[53];
result[2] = template[2] * sig[54];
result[3] = template[3] * sig[55];
result[4] = template[4] * sig[56];
result[5] = template[5] * sig[57];
result[6] = template[6] * sig[58];
result[7] = template[7] * sig[59];
result[8] = template[8] * sig[60];
result[9] = template[9] * sig[61];
result[10] = template[10] * sig[62];
result[11] = template[11] * sig[63];
result[12] = template[12] * sig[64];
result[13] = template[13] * sig[65];
result[14] = template[14] * sig[66];
result[15] = template[15] * sig[67];
end
54 :begin
result[0] = template[0] * sig[53];
result[1] = template[1] * sig[54];
result[2] = template[2] * sig[55];
result[3] = template[3] * sig[56];
result[4] = template[4] * sig[57];
result[5] = template[5] * sig[58];
result[6] = template[6] * sig[59];
result[7] = template[7] * sig[60];
result[8] = template[8] * sig[61];
result[9] = template[9] * sig[62];
result[10] = template[10] * sig[63];
result[11] = template[11] * sig[64];
result[12] = template[12] * sig[65];
result[13] = template[13] * sig[66];
result[14] = template[14] * sig[67];
result[15] = template[15] * sig[68];
end
55 :begin
result[0] = template[0] * sig[54];
result[1] = template[1] * sig[55];
result[2] = template[2] * sig[56];
result[3] = template[3] * sig[57];
result[4] = template[4] * sig[58];
result[5] = template[5] * sig[59];
result[6] = template[6] * sig[60];
result[7] = template[7] * sig[61];
result[8] = template[8] * sig[62];
result[9] = template[9] * sig[63];
result[10] = template[10] * sig[64];
result[11] = template[11] * sig[65];
result[12] = template[12] * sig[66];
result[13] = template[13] * sig[67];
result[14] = template[14] * sig[68];
result[15] = template[15] * sig[69];
end
56 :begin
result[0] = template[0] * sig[55];
result[1] = template[1] * sig[56];
result[2] = template[2] * sig[57];
result[3] = template[3] * sig[58];
result[4] = template[4] * sig[59];
result[5] = template[5] * sig[60];
result[6] = template[6] * sig[61];
result[7] = template[7] * sig[62];
result[8] = template[8] * sig[63];
result[9] = template[9] * sig[64];
result[10] = template[10] * sig[65];
result[11] = template[11] * sig[66];
result[12] = template[12] * sig[67];
result[13] = template[13] * sig[68];
result[14] = template[14] * sig[69];
result[15] = template[15] * sig[70];
end
57 :begin
result[0] = template[0] * sig[56];
result[1] = template[1] * sig[57];
result[2] = template[2] * sig[58];
result[3] = template[3] * sig[59];
result[4] = template[4] * sig[60];
result[5] = template[5] * sig[61];
result[6] = template[6] * sig[62];
result[7] = template[7] * sig[63];
result[8] = template[8] * sig[64];
result[9] = template[9] * sig[65];
result[10] = template[10] * sig[66];
result[11] = template[11] * sig[67];
result[12] = template[12] * sig[68];
result[13] = template[13] * sig[69];
result[14] = template[14] * sig[70];
result[15] = template[15] * sig[71];
end
58 :begin
result[0] = template[0] * sig[57];
result[1] = template[1] * sig[58];
result[2] = template[2] * sig[59];
result[3] = template[3] * sig[60];
result[4] = template[4] * sig[61];
result[5] = template[5] * sig[62];
result[6] = template[6] * sig[63];
result[7] = template[7] * sig[64];
result[8] = template[8] * sig[65];
result[9] = template[9] * sig[66];
result[10] = template[10] * sig[67];
result[11] = template[11] * sig[68];
result[12] = template[12] * sig[69];
result[13] = template[13] * sig[70];
result[14] = template[14] * sig[71];
result[15] = template[15] * sig[72];
end
59 :begin
result[0] = template[0] * sig[58];
result[1] = template[1] * sig[59];
result[2] = template[2] * sig[60];
result[3] = template[3] * sig[61];
result[4] = template[4] * sig[62];
result[5] = template[5] * sig[63];
result[6] = template[6] * sig[64];
result[7] = template[7] * sig[65];
result[8] = template[8] * sig[66];
result[9] = template[9] * sig[67];
result[10] = template[10] * sig[68];
result[11] = template[11] * sig[69];
result[12] = template[12] * sig[70];
result[13] = template[13] * sig[71];
result[14] = template[14] * sig[72];
result[15] = template[15] * sig[73];
end
60 :begin
result[0] = template[0] * sig[59];
result[1] = template[1] * sig[60];
result[2] = template[2] * sig[61];
result[3] = template[3] * sig[62];
result[4] = template[4] * sig[63];
result[5] = template[5] * sig[64];
result[6] = template[6] * sig[65];
result[7] = template[7] * sig[66];
result[8] = template[8] * sig[67];
result[9] = template[9] * sig[68];
result[10] = template[10] * sig[69];
result[11] = template[11] * sig[70];
result[12] = template[12] * sig[71];
result[13] = template[13] * sig[72];
result[14] = template[14] * sig[73];
result[15] = template[15] * sig[74];
end
61 :begin
result[0] = template[0] * sig[60];
result[1] = template[1] * sig[61];
result[2] = template[2] * sig[62];
result[3] = template[3] * sig[63];
result[4] = template[4] * sig[64];
result[5] = template[5] * sig[65];
result[6] = template[6] * sig[66];
result[7] = template[7] * sig[67];
result[8] = template[8] * sig[68];
result[9] = template[9] * sig[69];
result[10] = template[10] * sig[70];
result[11] = template[11] * sig[71];
result[12] = template[12] * sig[72];
result[13] = template[13] * sig[73];
result[14] = template[14] * sig[74];
result[15] = template[15] * sig[75];
end
62 :begin
result[0] = template[0] * sig[61];
result[1] = template[1] * sig[62];
result[2] = template[2] * sig[63];
result[3] = template[3] * sig[64];
result[4] = template[4] * sig[65];
result[5] = template[5] * sig[66];
result[6] = template[6] * sig[67];
result[7] = template[7] * sig[68];
result[8] = template[8] * sig[69];
result[9] = template[9] * sig[70];
result[10] = template[10] * sig[71];
result[11] = template[11] * sig[72];
result[12] = template[12] * sig[73];
result[13] = template[13] * sig[74];
result[14] = template[14] * sig[75];
result[15] = template[15] * sig[76];
end
63 :begin
result[0] = template[0] * sig[62];
result[1] = template[1] * sig[63];
result[2] = template[2] * sig[64];
result[3] = template[3] * sig[65];
result[4] = template[4] * sig[66];
result[5] = template[5] * sig[67];
result[6] = template[6] * sig[68];
result[7] = template[7] * sig[69];
result[8] = template[8] * sig[70];
result[9] = template[9] * sig[71];
result[10] = template[10] * sig[72];
result[11] = template[11] * sig[73];
result[12] = template[12] * sig[74];
result[13] = template[13] * sig[75];
result[14] = template[14] * sig[76];
result[15] = template[15] * sig[77];
end
64 :begin
result[0] = template[0] * sig[63];
result[1] = template[1] * sig[64];
result[2] = template[2] * sig[65];
result[3] = template[3] * sig[66];
result[4] = template[4] * sig[67];
result[5] = template[5] * sig[68];
result[6] = template[6] * sig[69];
result[7] = template[7] * sig[70];
result[8] = template[8] * sig[71];
result[9] = template[9] * sig[72];
result[10] = template[10] * sig[73];
result[11] = template[11] * sig[74];
result[12] = template[12] * sig[75];
result[13] = template[13] * sig[76];
result[14] = template[14] * sig[77];
result[15] = template[15] * sig[78];
end
65 :begin
result[0] = template[0] * sig[64];
result[1] = template[1] * sig[65];
result[2] = template[2] * sig[66];
result[3] = template[3] * sig[67];
result[4] = template[4] * sig[68];
result[5] = template[5] * sig[69];
result[6] = template[6] * sig[70];
result[7] = template[7] * sig[71];
result[8] = template[8] * sig[72];
result[9] = template[9] * sig[73];
result[10] = template[10] * sig[74];
result[11] = template[11] * sig[75];
result[12] = template[12] * sig[76];
result[13] = template[13] * sig[77];
result[14] = template[14] * sig[78];
result[15] = template[15] * sig[79];
end
66 :begin
result[0] = template[0] * sig[65];
result[1] = template[1] * sig[66];
result[2] = template[2] * sig[67];
result[3] = template[3] * sig[68];
result[4] = template[4] * sig[69];
result[5] = template[5] * sig[70];
result[6] = template[6] * sig[71];
result[7] = template[7] * sig[72];
result[8] = template[8] * sig[73];
result[9] = template[9] * sig[74];
result[10] = template[10] * sig[75];
result[11] = template[11] * sig[76];
result[12] = template[12] * sig[77];
result[13] = template[13] * sig[78];
result[14] = template[14] * sig[79];
result[15] = template[15] * sig[80];
end
67 :begin
result[0] = template[0] * sig[66];
result[1] = template[1] * sig[67];
result[2] = template[2] * sig[68];
result[3] = template[3] * sig[69];
result[4] = template[4] * sig[70];
result[5] = template[5] * sig[71];
result[6] = template[6] * sig[72];
result[7] = template[7] * sig[73];
result[8] = template[8] * sig[74];
result[9] = template[9] * sig[75];
result[10] = template[10] * sig[76];
result[11] = template[11] * sig[77];
result[12] = template[12] * sig[78];
result[13] = template[13] * sig[79];
result[14] = template[14] * sig[80];
result[15] = template[15] * sig[81];
end
68 :begin
result[0] = template[0] * sig[67];
result[1] = template[1] * sig[68];
result[2] = template[2] * sig[69];
result[3] = template[3] * sig[70];
result[4] = template[4] * sig[71];
result[5] = template[5] * sig[72];
result[6] = template[6] * sig[73];
result[7] = template[7] * sig[74];
result[8] = template[8] * sig[75];
result[9] = template[9] * sig[76];
result[10] = template[10] * sig[77];
result[11] = template[11] * sig[78];
result[12] = template[12] * sig[79];
result[13] = template[13] * sig[80];
result[14] = template[14] * sig[81];
result[15] = template[15] * sig[82];
end
69 :begin
result[0] = template[0] * sig[68];
result[1] = template[1] * sig[69];
result[2] = template[2] * sig[70];
result[3] = template[3] * sig[71];
result[4] = template[4] * sig[72];
result[5] = template[5] * sig[73];
result[6] = template[6] * sig[74];
result[7] = template[7] * sig[75];
result[8] = template[8] * sig[76];
result[9] = template[9] * sig[77];
result[10] = template[10] * sig[78];
result[11] = template[11] * sig[79];
result[12] = template[12] * sig[80];
result[13] = template[13] * sig[81];
result[14] = template[14] * sig[82];
result[15] = template[15] * sig[83];
end
70 :begin
result[0] = template[0] * sig[69];
result[1] = template[1] * sig[70];
result[2] = template[2] * sig[71];
result[3] = template[3] * sig[72];
result[4] = template[4] * sig[73];
result[5] = template[5] * sig[74];
result[6] = template[6] * sig[75];
result[7] = template[7] * sig[76];
result[8] = template[8] * sig[77];
result[9] = template[9] * sig[78];
result[10] = template[10] * sig[79];
result[11] = template[11] * sig[80];
result[12] = template[12] * sig[81];
result[13] = template[13] * sig[82];
result[14] = template[14] * sig[83];
result[15] = template[15] * sig[84];
end
71 :begin
result[0] = template[0] * sig[70];
result[1] = template[1] * sig[71];
result[2] = template[2] * sig[72];
result[3] = template[3] * sig[73];
result[4] = template[4] * sig[74];
result[5] = template[5] * sig[75];
result[6] = template[6] * sig[76];
result[7] = template[7] * sig[77];
result[8] = template[8] * sig[78];
result[9] = template[9] * sig[79];
result[10] = template[10] * sig[80];
result[11] = template[11] * sig[81];
result[12] = template[12] * sig[82];
result[13] = template[13] * sig[83];
result[14] = template[14] * sig[84];
result[15] = template[15] * sig[85];
end
72 :begin
result[0] = template[0] * sig[71];
result[1] = template[1] * sig[72];
result[2] = template[2] * sig[73];
result[3] = template[3] * sig[74];
result[4] = template[4] * sig[75];
result[5] = template[5] * sig[76];
result[6] = template[6] * sig[77];
result[7] = template[7] * sig[78];
result[8] = template[8] * sig[79];
result[9] = template[9] * sig[80];
result[10] = template[10] * sig[81];
result[11] = template[11] * sig[82];
result[12] = template[12] * sig[83];
result[13] = template[13] * sig[84];
result[14] = template[14] * sig[85];
result[15] = template[15] * sig[86];
end
73 :begin
result[0] = template[0] * sig[72];
result[1] = template[1] * sig[73];
result[2] = template[2] * sig[74];
result[3] = template[3] * sig[75];
result[4] = template[4] * sig[76];
result[5] = template[5] * sig[77];
result[6] = template[6] * sig[78];
result[7] = template[7] * sig[79];
result[8] = template[8] * sig[80];
result[9] = template[9] * sig[81];
result[10] = template[10] * sig[82];
result[11] = template[11] * sig[83];
result[12] = template[12] * sig[84];
result[13] = template[13] * sig[85];
result[14] = template[14] * sig[86];
result[15] = template[15] * sig[87];
end
74 :begin
result[0] = template[0] * sig[73];
result[1] = template[1] * sig[74];
result[2] = template[2] * sig[75];
result[3] = template[3] * sig[76];
result[4] = template[4] * sig[77];
result[5] = template[5] * sig[78];
result[6] = template[6] * sig[79];
result[7] = template[7] * sig[80];
result[8] = template[8] * sig[81];
result[9] = template[9] * sig[82];
result[10] = template[10] * sig[83];
result[11] = template[11] * sig[84];
result[12] = template[12] * sig[85];
result[13] = template[13] * sig[86];
result[14] = template[14] * sig[87];
result[15] = template[15] * sig[88];
end
75 :begin
result[0] = template[0] * sig[74];
result[1] = template[1] * sig[75];
result[2] = template[2] * sig[76];
result[3] = template[3] * sig[77];
result[4] = template[4] * sig[78];
result[5] = template[5] * sig[79];
result[6] = template[6] * sig[80];
result[7] = template[7] * sig[81];
result[8] = template[8] * sig[82];
result[9] = template[9] * sig[83];
result[10] = template[10] * sig[84];
result[11] = template[11] * sig[85];
result[12] = template[12] * sig[86];
result[13] = template[13] * sig[87];
result[14] = template[14] * sig[88];
result[15] = template[15] * sig[89];
end
76 :begin
result[0] = template[0] * sig[75];
result[1] = template[1] * sig[76];
result[2] = template[2] * sig[77];
result[3] = template[3] * sig[78];
result[4] = template[4] * sig[79];
result[5] = template[5] * sig[80];
result[6] = template[6] * sig[81];
result[7] = template[7] * sig[82];
result[8] = template[8] * sig[83];
result[9] = template[9] * sig[84];
result[10] = template[10] * sig[85];
result[11] = template[11] * sig[86];
result[12] = template[12] * sig[87];
result[13] = template[13] * sig[88];
result[14] = template[14] * sig[89];
result[15] = template[15] * sig[90];
end
77 :begin
result[0] = template[0] * sig[76];
result[1] = template[1] * sig[77];
result[2] = template[2] * sig[78];
result[3] = template[3] * sig[79];
result[4] = template[4] * sig[80];
result[5] = template[5] * sig[81];
result[6] = template[6] * sig[82];
result[7] = template[7] * sig[83];
result[8] = template[8] * sig[84];
result[9] = template[9] * sig[85];
result[10] = template[10] * sig[86];
result[11] = template[11] * sig[87];
result[12] = template[12] * sig[88];
result[13] = template[13] * sig[89];
result[14] = template[14] * sig[90];
result[15] = template[15] * sig[91];
end
78 :begin
result[0] = template[0] * sig[77];
result[1] = template[1] * sig[78];
result[2] = template[2] * sig[79];
result[3] = template[3] * sig[80];
result[4] = template[4] * sig[81];
result[5] = template[5] * sig[82];
result[6] = template[6] * sig[83];
result[7] = template[7] * sig[84];
result[8] = template[8] * sig[85];
result[9] = template[9] * sig[86];
result[10] = template[10] * sig[87];
result[11] = template[11] * sig[88];
result[12] = template[12] * sig[89];
result[13] = template[13] * sig[90];
result[14] = template[14] * sig[91];
result[15] = template[15] * sig[92];
end
79 :begin
result[0] = template[0] * sig[78];
result[1] = template[1] * sig[79];
result[2] = template[2] * sig[80];
result[3] = template[3] * sig[81];
result[4] = template[4] * sig[82];
result[5] = template[5] * sig[83];
result[6] = template[6] * sig[84];
result[7] = template[7] * sig[85];
result[8] = template[8] * sig[86];
result[9] = template[9] * sig[87];
result[10] = template[10] * sig[88];
result[11] = template[11] * sig[89];
result[12] = template[12] * sig[90];
result[13] = template[13] * sig[91];
result[14] = template[14] * sig[92];
result[15] = template[15] * sig[93];
end
80 :begin
result[0] = template[0] * sig[79];
result[1] = template[1] * sig[80];
result[2] = template[2] * sig[81];
result[3] = template[3] * sig[82];
result[4] = template[4] * sig[83];
result[5] = template[5] * sig[84];
result[6] = template[6] * sig[85];
result[7] = template[7] * sig[86];
result[8] = template[8] * sig[87];
result[9] = template[9] * sig[88];
result[10] = template[10] * sig[89];
result[11] = template[11] * sig[90];
result[12] = template[12] * sig[91];
result[13] = template[13] * sig[92];
result[14] = template[14] * sig[93];
result[15] = template[15] * sig[94];
end
81 :begin
result[0] = template[0] * sig[80];
result[1] = template[1] * sig[81];
result[2] = template[2] * sig[82];
result[3] = template[3] * sig[83];
result[4] = template[4] * sig[84];
result[5] = template[5] * sig[85];
result[6] = template[6] * sig[86];
result[7] = template[7] * sig[87];
result[8] = template[8] * sig[88];
result[9] = template[9] * sig[89];
result[10] = template[10] * sig[90];
result[11] = template[11] * sig[91];
result[12] = template[12] * sig[92];
result[13] = template[13] * sig[93];
result[14] = template[14] * sig[94];
result[15] = template[15] * sig[95];
end
82 :begin
result[0] = template[0] * sig[81];
result[1] = template[1] * sig[82];
result[2] = template[2] * sig[83];
result[3] = template[3] * sig[84];
result[4] = template[4] * sig[85];
result[5] = template[5] * sig[86];
result[6] = template[6] * sig[87];
result[7] = template[7] * sig[88];
result[8] = template[8] * sig[89];
result[9] = template[9] * sig[90];
result[10] = template[10] * sig[91];
result[11] = template[11] * sig[92];
result[12] = template[12] * sig[93];
result[13] = template[13] * sig[94];
result[14] = template[14] * sig[95];
result[15] = template[15] * sig[96];
end
83 :begin
result[0] = template[0] * sig[82];
result[1] = template[1] * sig[83];
result[2] = template[2] * sig[84];
result[3] = template[3] * sig[85];
result[4] = template[4] * sig[86];
result[5] = template[5] * sig[87];
result[6] = template[6] * sig[88];
result[7] = template[7] * sig[89];
result[8] = template[8] * sig[90];
result[9] = template[9] * sig[91];
result[10] = template[10] * sig[92];
result[11] = template[11] * sig[93];
result[12] = template[12] * sig[94];
result[13] = template[13] * sig[95];
result[14] = template[14] * sig[96];
result[15] = template[15] * sig[97];
end
84 :begin
result[0] = template[0] * sig[83];
result[1] = template[1] * sig[84];
result[2] = template[2] * sig[85];
result[3] = template[3] * sig[86];
result[4] = template[4] * sig[87];
result[5] = template[5] * sig[88];
result[6] = template[6] * sig[89];
result[7] = template[7] * sig[90];
result[8] = template[8] * sig[91];
result[9] = template[9] * sig[92];
result[10] = template[10] * sig[93];
result[11] = template[11] * sig[94];
result[12] = template[12] * sig[95];
result[13] = template[13] * sig[96];
result[14] = template[14] * sig[97];
result[15] = template[15] * sig[98];
end
85 :begin
result[0] = template[0] * sig[84];
result[1] = template[1] * sig[85];
result[2] = template[2] * sig[86];
result[3] = template[3] * sig[87];
result[4] = template[4] * sig[88];
result[5] = template[5] * sig[89];
result[6] = template[6] * sig[90];
result[7] = template[7] * sig[91];
result[8] = template[8] * sig[92];
result[9] = template[9] * sig[93];
result[10] = template[10] * sig[94];
result[11] = template[11] * sig[95];
result[12] = template[12] * sig[96];
result[13] = template[13] * sig[97];
result[14] = template[14] * sig[98];
result[15] = template[15] * sig[99];
end
86 :begin
result[0] = template[0] * sig[85];
result[1] = template[1] * sig[86];
result[2] = template[2] * sig[87];
result[3] = template[3] * sig[88];
result[4] = template[4] * sig[89];
result[5] = template[5] * sig[90];
result[6] = template[6] * sig[91];
result[7] = template[7] * sig[92];
result[8] = template[8] * sig[93];
result[9] = template[9] * sig[94];
result[10] = template[10] * sig[95];
result[11] = template[11] * sig[96];
result[12] = template[12] * sig[97];
result[13] = template[13] * sig[98];
result[14] = template[14] * sig[99];
result[15] = template[15] * sig[100];
end
87 :begin
result[0] = template[0] * sig[86];
result[1] = template[1] * sig[87];
result[2] = template[2] * sig[88];
result[3] = template[3] * sig[89];
result[4] = template[4] * sig[90];
result[5] = template[5] * sig[91];
result[6] = template[6] * sig[92];
result[7] = template[7] * sig[93];
result[8] = template[8] * sig[94];
result[9] = template[9] * sig[95];
result[10] = template[10] * sig[96];
result[11] = template[11] * sig[97];
result[12] = template[12] * sig[98];
result[13] = template[13] * sig[99];
result[14] = template[14] * sig[100];
result[15] = template[15] * sig[101];
end
88 :begin
result[0] = template[0] * sig[87];
result[1] = template[1] * sig[88];
result[2] = template[2] * sig[89];
result[3] = template[3] * sig[90];
result[4] = template[4] * sig[91];
result[5] = template[5] * sig[92];
result[6] = template[6] * sig[93];
result[7] = template[7] * sig[94];
result[8] = template[8] * sig[95];
result[9] = template[9] * sig[96];
result[10] = template[10] * sig[97];
result[11] = template[11] * sig[98];
result[12] = template[12] * sig[99];
result[13] = template[13] * sig[100];
result[14] = template[14] * sig[101];
result[15] = template[15] * sig[102];
end
89 :begin
result[0] = template[0] * sig[88];
result[1] = template[1] * sig[89];
result[2] = template[2] * sig[90];
result[3] = template[3] * sig[91];
result[4] = template[4] * sig[92];
result[5] = template[5] * sig[93];
result[6] = template[6] * sig[94];
result[7] = template[7] * sig[95];
result[8] = template[8] * sig[96];
result[9] = template[9] * sig[97];
result[10] = template[10] * sig[98];
result[11] = template[11] * sig[99];
result[12] = template[12] * sig[100];
result[13] = template[13] * sig[101];
result[14] = template[14] * sig[102];
result[15] = template[15] * sig[103];
end
90 :begin
result[0] = template[0] * sig[89];
result[1] = template[1] * sig[90];
result[2] = template[2] * sig[91];
result[3] = template[3] * sig[92];
result[4] = template[4] * sig[93];
result[5] = template[5] * sig[94];
result[6] = template[6] * sig[95];
result[7] = template[7] * sig[96];
result[8] = template[8] * sig[97];
result[9] = template[9] * sig[98];
result[10] = template[10] * sig[99];
result[11] = template[11] * sig[100];
result[12] = template[12] * sig[101];
result[13] = template[13] * sig[102];
result[14] = template[14] * sig[103];
result[15] = template[15] * sig[104];
end
91 :begin
result[0] = template[0] * sig[90];
result[1] = template[1] * sig[91];
result[2] = template[2] * sig[92];
result[3] = template[3] * sig[93];
result[4] = template[4] * sig[94];
result[5] = template[5] * sig[95];
result[6] = template[6] * sig[96];
result[7] = template[7] * sig[97];
result[8] = template[8] * sig[98];
result[9] = template[9] * sig[99];
result[10] = template[10] * sig[100];
result[11] = template[11] * sig[101];
result[12] = template[12] * sig[102];
result[13] = template[13] * sig[103];
result[14] = template[14] * sig[104];
result[15] = template[15] * sig[105];
end
92 :begin
result[0] = template[0] * sig[91];
result[1] = template[1] * sig[92];
result[2] = template[2] * sig[93];
result[3] = template[3] * sig[94];
result[4] = template[4] * sig[95];
result[5] = template[5] * sig[96];
result[6] = template[6] * sig[97];
result[7] = template[7] * sig[98];
result[8] = template[8] * sig[99];
result[9] = template[9] * sig[100];
result[10] = template[10] * sig[101];
result[11] = template[11] * sig[102];
result[12] = template[12] * sig[103];
result[13] = template[13] * sig[104];
result[14] = template[14] * sig[105];
result[15] = template[15] * sig[106];
end
93 :begin
result[0] = template[0] * sig[92];
result[1] = template[1] * sig[93];
result[2] = template[2] * sig[94];
result[3] = template[3] * sig[95];
result[4] = template[4] * sig[96];
result[5] = template[5] * sig[97];
result[6] = template[6] * sig[98];
result[7] = template[7] * sig[99];
result[8] = template[8] * sig[100];
result[9] = template[9] * sig[101];
result[10] = template[10] * sig[102];
result[11] = template[11] * sig[103];
result[12] = template[12] * sig[104];
result[13] = template[13] * sig[105];
result[14] = template[14] * sig[106];
result[15] = template[15] * sig[107];
end
94 :begin
result[0] = template[0] * sig[93];
result[1] = template[1] * sig[94];
result[2] = template[2] * sig[95];
result[3] = template[3] * sig[96];
result[4] = template[4] * sig[97];
result[5] = template[5] * sig[98];
result[6] = template[6] * sig[99];
result[7] = template[7] * sig[100];
result[8] = template[8] * sig[101];
result[9] = template[9] * sig[102];
result[10] = template[10] * sig[103];
result[11] = template[11] * sig[104];
result[12] = template[12] * sig[105];
result[13] = template[13] * sig[106];
result[14] = template[14] * sig[107];
result[15] = template[15] * sig[108];
end
95 :begin
result[0] = template[0] * sig[94];
result[1] = template[1] * sig[95];
result[2] = template[2] * sig[96];
result[3] = template[3] * sig[97];
result[4] = template[4] * sig[98];
result[5] = template[5] * sig[99];
result[6] = template[6] * sig[100];
result[7] = template[7] * sig[101];
result[8] = template[8] * sig[102];
result[9] = template[9] * sig[103];
result[10] = template[10] * sig[104];
result[11] = template[11] * sig[105];
result[12] = template[12] * sig[106];
result[13] = template[13] * sig[107];
result[14] = template[14] * sig[108];
result[15] = template[15] * sig[109];
end
96 :begin
result[0] = template[0] * sig[95];
result[1] = template[1] * sig[96];
result[2] = template[2] * sig[97];
result[3] = template[3] * sig[98];
result[4] = template[4] * sig[99];
result[5] = template[5] * sig[100];
result[6] = template[6] * sig[101];
result[7] = template[7] * sig[102];
result[8] = template[8] * sig[103];
result[9] = template[9] * sig[104];
result[10] = template[10] * sig[105];
result[11] = template[11] * sig[106];
result[12] = template[12] * sig[107];
result[13] = template[13] * sig[108];
result[14] = template[14] * sig[109];
result[15] = template[15] * sig[110];
end
97 :begin
result[0] = template[0] * sig[96];
result[1] = template[1] * sig[97];
result[2] = template[2] * sig[98];
result[3] = template[3] * sig[99];
result[4] = template[4] * sig[100];
result[5] = template[5] * sig[101];
result[6] = template[6] * sig[102];
result[7] = template[7] * sig[103];
result[8] = template[8] * sig[104];
result[9] = template[9] * sig[105];
result[10] = template[10] * sig[106];
result[11] = template[11] * sig[107];
result[12] = template[12] * sig[108];
result[13] = template[13] * sig[109];
result[14] = template[14] * sig[110];
result[15] = template[15] * sig[111];
end
98 :begin
result[0] = template[0] * sig[97];
result[1] = template[1] * sig[98];
result[2] = template[2] * sig[99];
result[3] = template[3] * sig[100];
result[4] = template[4] * sig[101];
result[5] = template[5] * sig[102];
result[6] = template[6] * sig[103];
result[7] = template[7] * sig[104];
result[8] = template[8] * sig[105];
result[9] = template[9] * sig[106];
result[10] = template[10] * sig[107];
result[11] = template[11] * sig[108];
result[12] = template[12] * sig[109];
result[13] = template[13] * sig[110];
result[14] = template[14] * sig[111];
result[15] = template[15] * sig[112];
end
99 :begin
result[0] = template[0] * sig[98];
result[1] = template[1] * sig[99];
result[2] = template[2] * sig[100];
result[3] = template[3] * sig[101];
result[4] = template[4] * sig[102];
result[5] = template[5] * sig[103];
result[6] = template[6] * sig[104];
result[7] = template[7] * sig[105];
result[8] = template[8] * sig[106];
result[9] = template[9] * sig[107];
result[10] = template[10] * sig[108];
result[11] = template[11] * sig[109];
result[12] = template[12] * sig[110];
result[13] = template[13] * sig[111];
result[14] = template[14] * sig[112];
result[15] = template[15] * sig[113];
end
100 :begin
result[0] = template[0] * sig[99];
result[1] = template[1] * sig[100];
result[2] = template[2] * sig[101];
result[3] = template[3] * sig[102];
result[4] = template[4] * sig[103];
result[5] = template[5] * sig[104];
result[6] = template[6] * sig[105];
result[7] = template[7] * sig[106];
result[8] = template[8] * sig[107];
result[9] = template[9] * sig[108];
result[10] = template[10] * sig[109];
result[11] = template[11] * sig[110];
result[12] = template[12] * sig[111];
result[13] = template[13] * sig[112];
result[14] = template[14] * sig[113];
result[15] = template[15] * sig[114];
end
101 :begin
result[0] = template[0] * sig[100];
result[1] = template[1] * sig[101];
result[2] = template[2] * sig[102];
result[3] = template[3] * sig[103];
result[4] = template[4] * sig[104];
result[5] = template[5] * sig[105];
result[6] = template[6] * sig[106];
result[7] = template[7] * sig[107];
result[8] = template[8] * sig[108];
result[9] = template[9] * sig[109];
result[10] = template[10] * sig[110];
result[11] = template[11] * sig[111];
result[12] = template[12] * sig[112];
result[13] = template[13] * sig[113];
result[14] = template[14] * sig[114];
result[15] = template[15] * sig[115];
end
102 :begin
result[0] = template[0] * sig[101];
result[1] = template[1] * sig[102];
result[2] = template[2] * sig[103];
result[3] = template[3] * sig[104];
result[4] = template[4] * sig[105];
result[5] = template[5] * sig[106];
result[6] = template[6] * sig[107];
result[7] = template[7] * sig[108];
result[8] = template[8] * sig[109];
result[9] = template[9] * sig[110];
result[10] = template[10] * sig[111];
result[11] = template[11] * sig[112];
result[12] = template[12] * sig[113];
result[13] = template[13] * sig[114];
result[14] = template[14] * sig[115];
result[15] = template[15] * sig[116];
end
103 :begin
result[0] = template[0] * sig[102];
result[1] = template[1] * sig[103];
result[2] = template[2] * sig[104];
result[3] = template[3] * sig[105];
result[4] = template[4] * sig[106];
result[5] = template[5] * sig[107];
result[6] = template[6] * sig[108];
result[7] = template[7] * sig[109];
result[8] = template[8] * sig[110];
result[9] = template[9] * sig[111];
result[10] = template[10] * sig[112];
result[11] = template[11] * sig[113];
result[12] = template[12] * sig[114];
result[13] = template[13] * sig[115];
result[14] = template[14] * sig[116];
result[15] = template[15] * sig[117];
end
104 :begin
result[0] = template[0] * sig[103];
result[1] = template[1] * sig[104];
result[2] = template[2] * sig[105];
result[3] = template[3] * sig[106];
result[4] = template[4] * sig[107];
result[5] = template[5] * sig[108];
result[6] = template[6] * sig[109];
result[7] = template[7] * sig[110];
result[8] = template[8] * sig[111];
result[9] = template[9] * sig[112];
result[10] = template[10] * sig[113];
result[11] = template[11] * sig[114];
result[12] = template[12] * sig[115];
result[13] = template[13] * sig[116];
result[14] = template[14] * sig[117];
result[15] = template[15] * sig[118];
end
105 :begin
result[0] = template[0] * sig[104];
result[1] = template[1] * sig[105];
result[2] = template[2] * sig[106];
result[3] = template[3] * sig[107];
result[4] = template[4] * sig[108];
result[5] = template[5] * sig[109];
result[6] = template[6] * sig[110];
result[7] = template[7] * sig[111];
result[8] = template[8] * sig[112];
result[9] = template[9] * sig[113];
result[10] = template[10] * sig[114];
result[11] = template[11] * sig[115];
result[12] = template[12] * sig[116];
result[13] = template[13] * sig[117];
result[14] = template[14] * sig[118];
result[15] = template[15] * sig[119];
end
106 :begin
result[0] = template[0] * sig[105];
result[1] = template[1] * sig[106];
result[2] = template[2] * sig[107];
result[3] = template[3] * sig[108];
result[4] = template[4] * sig[109];
result[5] = template[5] * sig[110];
result[6] = template[6] * sig[111];
result[7] = template[7] * sig[112];
result[8] = template[8] * sig[113];
result[9] = template[9] * sig[114];
result[10] = template[10] * sig[115];
result[11] = template[11] * sig[116];
result[12] = template[12] * sig[117];
result[13] = template[13] * sig[118];
result[14] = template[14] * sig[119];
result[15] = template[15] * sig[120];
end
107 :begin
result[0] = template[0] * sig[106];
result[1] = template[1] * sig[107];
result[2] = template[2] * sig[108];
result[3] = template[3] * sig[109];
result[4] = template[4] * sig[110];
result[5] = template[5] * sig[111];
result[6] = template[6] * sig[112];
result[7] = template[7] * sig[113];
result[8] = template[8] * sig[114];
result[9] = template[9] * sig[115];
result[10] = template[10] * sig[116];
result[11] = template[11] * sig[117];
result[12] = template[12] * sig[118];
result[13] = template[13] * sig[119];
result[14] = template[14] * sig[120];
result[15] = template[15] * sig[121];
end
108 :begin
result[0] = template[0] * sig[107];
result[1] = template[1] * sig[108];
result[2] = template[2] * sig[109];
result[3] = template[3] * sig[110];
result[4] = template[4] * sig[111];
result[5] = template[5] * sig[112];
result[6] = template[6] * sig[113];
result[7] = template[7] * sig[114];
result[8] = template[8] * sig[115];
result[9] = template[9] * sig[116];
result[10] = template[10] * sig[117];
result[11] = template[11] * sig[118];
result[12] = template[12] * sig[119];
result[13] = template[13] * sig[120];
result[14] = template[14] * sig[121];
result[15] = template[15] * sig[122];
end
109 :begin
result[0] = template[0] * sig[108];
result[1] = template[1] * sig[109];
result[2] = template[2] * sig[110];
result[3] = template[3] * sig[111];
result[4] = template[4] * sig[112];
result[5] = template[5] * sig[113];
result[6] = template[6] * sig[114];
result[7] = template[7] * sig[115];
result[8] = template[8] * sig[116];
result[9] = template[9] * sig[117];
result[10] = template[10] * sig[118];
result[11] = template[11] * sig[119];
result[12] = template[12] * sig[120];
result[13] = template[13] * sig[121];
result[14] = template[14] * sig[122];
result[15] = template[15] * sig[123];
end
110 :begin
result[0] = template[0] * sig[109];
result[1] = template[1] * sig[110];
result[2] = template[2] * sig[111];
result[3] = template[3] * sig[112];
result[4] = template[4] * sig[113];
result[5] = template[5] * sig[114];
result[6] = template[6] * sig[115];
result[7] = template[7] * sig[116];
result[8] = template[8] * sig[117];
result[9] = template[9] * sig[118];
result[10] = template[10] * sig[119];
result[11] = template[11] * sig[120];
result[12] = template[12] * sig[121];
result[13] = template[13] * sig[122];
result[14] = template[14] * sig[123];
result[15] = template[15] * sig[124];
end
111 :begin
result[0] = template[0] * sig[110];
result[1] = template[1] * sig[111];
result[2] = template[2] * sig[112];
result[3] = template[3] * sig[113];
result[4] = template[4] * sig[114];
result[5] = template[5] * sig[115];
result[6] = template[6] * sig[116];
result[7] = template[7] * sig[117];
result[8] = template[8] * sig[118];
result[9] = template[9] * sig[119];
result[10] = template[10] * sig[120];
result[11] = template[11] * sig[121];
result[12] = template[12] * sig[122];
result[13] = template[13] * sig[123];
result[14] = template[14] * sig[124];
result[15] = template[15] * sig[125];
end
112 :begin
result[0] = template[0] * sig[111];
result[1] = template[1] * sig[112];
result[2] = template[2] * sig[113];
result[3] = template[3] * sig[114];
result[4] = template[4] * sig[115];
result[5] = template[5] * sig[116];
result[6] = template[6] * sig[117];
result[7] = template[7] * sig[118];
result[8] = template[8] * sig[119];
result[9] = template[9] * sig[120];
result[10] = template[10] * sig[121];
result[11] = template[11] * sig[122];
result[12] = template[12] * sig[123];
result[13] = template[13] * sig[124];
result[14] = template[14] * sig[125];
result[15] = template[15] * sig[126];
end
113 :begin
result[0] = template[0] * sig[112];
result[1] = template[1] * sig[113];
result[2] = template[2] * sig[114];
result[3] = template[3] * sig[115];
result[4] = template[4] * sig[116];
result[5] = template[5] * sig[117];
result[6] = template[6] * sig[118];
result[7] = template[7] * sig[119];
result[8] = template[8] * sig[120];
result[9] = template[9] * sig[121];
result[10] = template[10] * sig[122];
result[11] = template[11] * sig[123];
result[12] = template[12] * sig[124];
result[13] = template[13] * sig[125];
result[14] = template[14] * sig[126];
result[15] = template[15] * sig[127];
end
114 :begin
result[0] = template[0] * sig[113];
result[1] = template[1] * sig[114];
result[2] = template[2] * sig[115];
result[3] = template[3] * sig[116];
result[4] = template[4] * sig[117];
result[5] = template[5] * sig[118];
result[6] = template[6] * sig[119];
result[7] = template[7] * sig[120];
result[8] = template[8] * sig[121];
result[9] = template[9] * sig[122];
result[10] = template[10] * sig[123];
result[11] = template[11] * sig[124];
result[12] = template[12] * sig[125];
result[13] = template[13] * sig[126];
result[14] = template[14] * sig[127];
result[15] = template[15] * sig[0];
end
115 :begin
result[0] = template[0] * sig[114];
result[1] = template[1] * sig[115];
result[2] = template[2] * sig[116];
result[3] = template[3] * sig[117];
result[4] = template[4] * sig[118];
result[5] = template[5] * sig[119];
result[6] = template[6] * sig[120];
result[7] = template[7] * sig[121];
result[8] = template[8] * sig[122];
result[9] = template[9] * sig[123];
result[10] = template[10] * sig[124];
result[11] = template[11] * sig[125];
result[12] = template[12] * sig[126];
result[13] = template[13] * sig[127];
result[14] = template[14] * sig[0];
result[15] = template[15] * sig[1];
end
116 :begin
result[0] = template[0] * sig[115];
result[1] = template[1] * sig[116];
result[2] = template[2] * sig[117];
result[3] = template[3] * sig[118];
result[4] = template[4] * sig[119];
result[5] = template[5] * sig[120];
result[6] = template[6] * sig[121];
result[7] = template[7] * sig[122];
result[8] = template[8] * sig[123];
result[9] = template[9] * sig[124];
result[10] = template[10] * sig[125];
result[11] = template[11] * sig[126];
result[12] = template[12] * sig[127];
result[13] = template[13] * sig[0];
result[14] = template[14] * sig[1];
result[15] = template[15] * sig[2];
end
117 :begin
result[0] = template[0] * sig[116];
result[1] = template[1] * sig[117];
result[2] = template[2] * sig[118];
result[3] = template[3] * sig[119];
result[4] = template[4] * sig[120];
result[5] = template[5] * sig[121];
result[6] = template[6] * sig[122];
result[7] = template[7] * sig[123];
result[8] = template[8] * sig[124];
result[9] = template[9] * sig[125];
result[10] = template[10] * sig[126];
result[11] = template[11] * sig[127];
result[12] = template[12] * sig[0];
result[13] = template[13] * sig[1];
result[14] = template[14] * sig[2];
result[15] = template[15] * sig[3];
end
118 :begin
result[0] = template[0] * sig[117];
result[1] = template[1] * sig[118];
result[2] = template[2] * sig[119];
result[3] = template[3] * sig[120];
result[4] = template[4] * sig[121];
result[5] = template[5] * sig[122];
result[6] = template[6] * sig[123];
result[7] = template[7] * sig[124];
result[8] = template[8] * sig[125];
result[9] = template[9] * sig[126];
result[10] = template[10] * sig[127];
result[11] = template[11] * sig[0];
result[12] = template[12] * sig[1];
result[13] = template[13] * sig[2];
result[14] = template[14] * sig[3];
result[15] = template[15] * sig[4];
end
119 :begin
result[0] = template[0] * sig[118];
result[1] = template[1] * sig[119];
result[2] = template[2] * sig[120];
result[3] = template[3] * sig[121];
result[4] = template[4] * sig[122];
result[5] = template[5] * sig[123];
result[6] = template[6] * sig[124];
result[7] = template[7] * sig[125];
result[8] = template[8] * sig[126];
result[9] = template[9] * sig[127];
result[10] = template[10] * sig[0];
result[11] = template[11] * sig[1];
result[12] = template[12] * sig[2];
result[13] = template[13] * sig[3];
result[14] = template[14] * sig[4];
result[15] = template[15] * sig[5];
end
120 :begin
result[0] = template[0] * sig[119];
result[1] = template[1] * sig[120];
result[2] = template[2] * sig[121];
result[3] = template[3] * sig[122];
result[4] = template[4] * sig[123];
result[5] = template[5] * sig[124];
result[6] = template[6] * sig[125];
result[7] = template[7] * sig[126];
result[8] = template[8] * sig[127];
result[9] = template[9] * sig[0];
result[10] = template[10] * sig[1];
result[11] = template[11] * sig[2];
result[12] = template[12] * sig[3];
result[13] = template[13] * sig[4];
result[14] = template[14] * sig[5];
result[15] = template[15] * sig[6];
end
121 :begin
result[0] = template[0] * sig[120];
result[1] = template[1] * sig[121];
result[2] = template[2] * sig[122];
result[3] = template[3] * sig[123];
result[4] = template[4] * sig[124];
result[5] = template[5] * sig[125];
result[6] = template[6] * sig[126];
result[7] = template[7] * sig[127];
result[8] = template[8] * sig[0];
result[9] = template[9] * sig[1];
result[10] = template[10] * sig[2];
result[11] = template[11] * sig[3];
result[12] = template[12] * sig[4];
result[13] = template[13] * sig[5];
result[14] = template[14] * sig[6];
result[15] = template[15] * sig[7];
end
122 :begin
result[0] = template[0] * sig[121];
result[1] = template[1] * sig[122];
result[2] = template[2] * sig[123];
result[3] = template[3] * sig[124];
result[4] = template[4] * sig[125];
result[5] = template[5] * sig[126];
result[6] = template[6] * sig[127];
result[7] = template[7] * sig[0];
result[8] = template[8] * sig[1];
result[9] = template[9] * sig[2];
result[10] = template[10] * sig[3];
result[11] = template[11] * sig[4];
result[12] = template[12] * sig[5];
result[13] = template[13] * sig[6];
result[14] = template[14] * sig[7];
result[15] = template[15] * sig[8];
end
123 :begin
result[0] = template[0] * sig[122];
result[1] = template[1] * sig[123];
result[2] = template[2] * sig[124];
result[3] = template[3] * sig[125];
result[4] = template[4] * sig[126];
result[5] = template[5] * sig[127];
result[6] = template[6] * sig[0];
result[7] = template[7] * sig[1];
result[8] = template[8] * sig[2];
result[9] = template[9] * sig[3];
result[10] = template[10] * sig[4];
result[11] = template[11] * sig[5];
result[12] = template[12] * sig[6];
result[13] = template[13] * sig[7];
result[14] = template[14] * sig[8];
result[15] = template[15] * sig[9];
end
124 :begin
result[0] = template[0] * sig[123];
result[1] = template[1] * sig[124];
result[2] = template[2] * sig[125];
result[3] = template[3] * sig[126];
result[4] = template[4] * sig[127];
result[5] = template[5] * sig[0];
result[6] = template[6] * sig[1];
result[7] = template[7] * sig[2];
result[8] = template[8] * sig[3];
result[9] = template[9] * sig[4];
result[10] = template[10] * sig[5];
result[11] = template[11] * sig[6];
result[12] = template[12] * sig[7];
result[13] = template[13] * sig[8];
result[14] = template[14] * sig[9];
result[15] = template[15] * sig[10];
end
125 :begin
result[0] = template[0] * sig[124];
result[1] = template[1] * sig[125];
result[2] = template[2] * sig[126];
result[3] = template[3] * sig[127];
result[4] = template[4] * sig[0];
result[5] = template[5] * sig[1];
result[6] = template[6] * sig[2];
result[7] = template[7] * sig[3];
result[8] = template[8] * sig[4];
result[9] = template[9] * sig[5];
result[10] = template[10] * sig[6];
result[11] = template[11] * sig[7];
result[12] = template[12] * sig[8];
result[13] = template[13] * sig[9];
result[14] = template[14] * sig[10];
result[15] = template[15] * sig[11];
end
126 :begin
result[0] = template[0] * sig[125];
result[1] = template[1] * sig[126];
result[2] = template[2] * sig[127];
result[3] = template[3] * sig[0];
result[4] = template[4] * sig[1];
result[5] = template[5] * sig[2];
result[6] = template[6] * sig[3];
result[7] = template[7] * sig[4];
result[8] = template[8] * sig[5];
result[9] = template[9] * sig[6];
result[10] = template[10] * sig[7];
result[11] = template[11] * sig[8];
result[12] = template[12] * sig[9];
result[13] = template[13] * sig[10];
result[14] = template[14] * sig[11];
result[15] = template[15] * sig[12];
end
127 :begin
result[0] = template[0] * sig[126];
result[1] = template[1] * sig[127];
result[2] = template[2] * sig[0];
result[3] = template[3] * sig[1];
result[4] = template[4] * sig[2];
result[5] = template[5] * sig[3];
result[6] = template[6] * sig[4];
result[7] = template[7] * sig[5];
result[8] = template[8] * sig[6];
result[9] = template[9] * sig[7];
result[10] = template[10] * sig[8];
result[11] = template[11] * sig[9];
result[12] = template[12] * sig[10];
result[13] = template[13] * sig[11];
result[14] = template[14] * sig[12];
result[15] = template[15] * sig[13];
end
128 :begin
result[0] = template[0] * sig[127];
result[1] = template[1] * sig[0];
result[2] = template[2] * sig[1];
result[3] = template[3] * sig[2];
result[4] = template[4] * sig[3];
result[5] = template[5] * sig[4];
result[6] = template[6] * sig[5];
result[7] = template[7] * sig[6];
result[8] = template[8] * sig[7];
result[9] = template[9] * sig[8];
result[10] = template[10] * sig[9];
result[11] = template[11] * sig[10];
result[12] = template[12] * sig[11];
result[13] = template[13] * sig[12];
result[14] = template[14] * sig[13];
result[15] = template[15] * sig[14];
end

	default : begin
result[0] = 0;
result[1] = 0;
result[2] = 0;
result[3] = 0;
result[4] = 0;
result[5] = 0;
result[6] = 0;
result[7] = 0;
result[8] = 0;
result[9] = 0;
result[10] = 0;
result[11] = 0;
result[12] = 0;
result[13] = 0;
result[14] = 0;
result[15] = 0;
end
endcase
end
assign sum = result[0]+result[1]+result[2]+result[3]+result[4]+result[5]+result[6]+result[7]+result[8]+result[9]
			+result[10]+result[11]+result[12]+result[13]+result[14]+result[15];


 assign write_jloop				= (write & (address == 9'd1));  
 assign write_template[0]       = (write & (address == 9'd0));
 assign write_template[1]       = (write & (address == 9'd0));
 assign write_template[2]       = (write & (address == 9'd0));
 assign write_template[3]       = (write & (address == 9'd0));
 assign write_template[4]       = (write & (address == 9'd4));
 assign write_template[5]       = (write & (address == 9'd4));
 assign write_template[6]       = (write & (address == 9'd4));
 assign write_template[7]       = (write & (address == 9'd4));
 assign write_template[8]       = (write & (address == 9'd8));
 assign write_template[9]       = (write & (address == 9'd8));
 assign write_template[10]      = (write & (address == 9'd8));
 assign write_template[11]      = (write & (address == 9'd8));
 assign write_template[12]      = (write & (address == 9'd12));
 assign write_template[13]      = (write & (address == 9'd12));
 assign write_template[14]      = (write & (address == 9'd12));
 assign write_template[15]      = (write & (address == 9'd12));
 
 assign write_sig[0]       = (write & (address == 9'd13));
 assign write_sig[1]       = (write & (address == 9'd14));
 assign write_sig[2]       = (write & (address == 9'd15));
 assign write_sig[3]       = (write & (address == 9'd16));
 assign write_sig[4]       = (write & (address == 9'd17));
 assign write_sig[5]       = (write & (address == 9'd18));
 assign write_sig[6]       = (write & (address == 9'd19));
 assign write_sig[7]       = (write & (address == 9'd20));
 assign write_sig[8]       = (write & (address == 9'd21));
 assign write_sig[9]       = (write & (address == 9'd22));
 assign write_sig[10]      = (write & (address == 9'd23));
 assign write_sig[11]      = (write & (address == 9'd24));
 assign write_sig[12]      = (write & (address == 9'd25));
 assign write_sig[13]      = (write & (address == 9'd26));
 assign write_sig[14]      = (write & (address == 9'd27));
 assign write_sig[15]      = (write & (address == 9'd28));
 assign write_sig[16]      = (write & (address == 9'd29));
 assign write_sig[17]      = (write & (address == 9'd30));
 assign write_sig[18]      = (write & (address == 9'd31));
 assign write_sig[19]      = (write & (address == 9'd32));
 assign write_sig[20]      = (write & (address == 9'd33));
 assign write_sig[21]      = (write & (address == 9'd34));
 assign write_sig[22]      = (write & (address == 9'd35));
 assign write_sig[23]      = (write & (address == 9'd36));
 assign write_sig[24]      = (write & (address == 9'd37));
 assign write_sig[25]      = (write & (address == 9'd38));
 assign write_sig[26]      = (write & (address == 9'd39));
 assign write_sig[27]      = (write & (address == 9'd40));
 assign write_sig[28]      = (write & (address == 9'd41));
 assign write_sig[29]      = (write & (address == 9'd42));
 assign write_sig[30]      = (write & (address == 9'd43));
 assign write_sig[31]      = (write & (address == 9'd44));
 assign write_sig[32]      = (write & (address == 9'd45));
 assign write_sig[33]      = (write & (address == 9'd46));
 assign write_sig[34]      = (write & (address == 9'd47));
 assign write_sig[35]      = (write & (address == 9'd48));
 assign write_sig[36]      = (write & (address == 9'd49));
 assign write_sig[37]      = (write & (address == 9'd50));
 assign write_sig[38]      = (write & (address == 9'd51));
 assign write_sig[39]      = (write & (address == 9'd52));
 assign write_sig[40]      = (write & (address == 9'd53));
 assign write_sig[41]      = (write & (address == 9'd54));
 assign write_sig[42]      = (write & (address == 9'd55));
 assign write_sig[43]      = (write & (address == 9'd56));
 assign write_sig[44]      = (write & (address == 9'd57));
 assign write_sig[45]      = (write & (address == 9'd58));
 assign write_sig[46]      = (write & (address == 9'd59));
 assign write_sig[47]      = (write & (address == 9'd60));
 assign write_sig[48]      = (write & (address == 9'd61));
 assign write_sig[49]      = (write & (address == 9'd62));
 assign write_sig[50]      = (write & (address == 9'd63));
 assign write_sig[51]      = (write & (address == 9'd64));
 assign write_sig[52]      = (write & (address == 9'd65));
 assign write_sig[53]      = (write & (address == 9'd66));
 assign write_sig[54]      = (write & (address == 9'd67));
 assign write_sig[55]      = (write & (address == 9'd68));
 assign write_sig[56]      = (write & (address == 9'd69));
 assign write_sig[57]      = (write & (address == 9'd70));
 assign write_sig[58]      = (write & (address == 9'd71));
 assign write_sig[59]      = (write & (address == 9'd72));
 assign write_sig[60]      = (write & (address == 9'd73));
 assign write_sig[61]      = (write & (address == 9'd74));
 assign write_sig[62]      = (write & (address == 9'd75));
 assign write_sig[63]      = (write & (address == 9'd76));
 assign write_sig[64]      = (write & (address == 9'd77));
 assign write_sig[65]      = (write & (address == 9'd78));
 assign write_sig[66]      = (write & (address == 9'd79));
 assign write_sig[67]      = (write & (address == 9'd80));
 assign write_sig[68]      = (write & (address == 9'd81));
 assign write_sig[69]      = (write & (address == 9'd82));
 assign write_sig[70]      = (write & (address == 9'd83));
 assign write_sig[71]      = (write & (address == 9'd84));
 assign write_sig[72]      = (write & (address == 9'd85));
 assign write_sig[73]      = (write & (address == 9'd86));
 assign write_sig[74]      = (write & (address == 9'd87));
 assign write_sig[75]      = (write & (address == 9'd88));
 assign write_sig[76]      = (write & (address == 9'd89));
 assign write_sig[77]      = (write & (address == 9'd90));
 assign write_sig[78]      = (write & (address == 9'd91));
 assign write_sig[79]      = (write & (address == 9'd92));
 assign write_sig[80]      = (write & (address == 9'd93));
 assign write_sig[81]      = (write & (address == 9'd94));
 assign write_sig[82]      = (write & (address == 9'd95));
 assign write_sig[83]      = (write & (address == 9'd96));
 assign write_sig[84]      = (write & (address == 9'd97));
 assign write_sig[85]      = (write & (address == 9'd98));
 assign write_sig[86]      = (write & (address == 9'd99));
 assign write_sig[87]      = (write & (address == 9'd100));
 assign write_sig[88]      = (write & (address == 9'd101));
 assign write_sig[89]      = (write & (address == 9'd102));
 assign write_sig[90]      = (write & (address == 9'd103));
 assign write_sig[91]      = (write & (address == 9'd104));
 assign write_sig[92]      = (write & (address == 9'd105));
 assign write_sig[93]      = (write & (address == 9'd106));
 assign write_sig[94]      = (write & (address == 9'd107));
 assign write_sig[95]      = (write & (address == 9'd108));
 assign write_sig[96]      = (write & (address == 9'd109));
 assign write_sig[97]      = (write & (address == 9'd110));
 assign write_sig[98]      = (write & (address == 9'd111));
 assign write_sig[99]      = (write & (address == 9'd112));
 assign write_sig[100]     = (write & (address == 9'd113));
 assign write_sig[101]     = (write & (address == 9'd114));
 assign write_sig[102]     = (write & (address == 9'd115));
 assign write_sig[103]     = (write & (address == 9'd116));
 assign write_sig[104]     = (write & (address == 9'd117));
 assign write_sig[105]     = (write & (address == 9'd118));
 assign write_sig[106]     = (write & (address == 9'd119));
 assign write_sig[107]     = (write & (address == 9'd120));
 assign write_sig[108]     = (write & (address == 9'd121));
 assign write_sig[109]     = (write & (address == 9'd122));
 assign write_sig[110]     = (write & (address == 9'd123));
 assign write_sig[111]     = (write & (address == 9'd124));
 assign write_sig[112]     = (write & (address == 9'd125));
 assign write_sig[113]     = (write & (address == 9'd126));
 assign write_sig[114]     = (write & (address == 9'd127));
 assign write_sig[115]     = (write & (address == 9'd128));
 assign write_sig[116]     = (write & (address == 9'd129));
 assign write_sig[117]     = (write & (address == 9'd130));
 assign write_sig[118]     = (write & (address == 9'd131));
 assign write_sig[119]     = (write & (address == 9'd132));
 assign write_sig[120]     = (write & (address == 9'd133));
 assign write_sig[121]     = (write & (address == 9'd134));
 assign write_sig[122]     = (write & (address == 9'd135));
 assign write_sig[123]     = (write & (address == 9'd136));
 assign write_sig[124]     = (write & (address == 9'd137));
 assign write_sig[125]     = (write & (address == 9'd138));
 assign write_sig[126]     = (write & (address == 9'd139));
 assign write_sig[127]     = (write & (address == 9'd140));
 
 
 assign write_ctl   	= (write & (address == 9'd2));
 assign read_acc    	= (read & (address  == 9'd3));
   
 assign write_retval    = ((hw_ctl == 1'h1) & (hw_ctl ^ hw_ctl_old));
   
 assign readdata = read_acc ? acc : 32'h0;
   
endmodule					   

// module mul_16 (
			// input [7:0] template0,
			// input [7:0] template1,
			// input [7:0] template2,
			// input [7:0] template3,
			// input [7:0] template4,
			// input [7:0] template5,
			// input [7:0] template6,
			// input [7:0] template7,
			// input [7:0] template8,
			// input [7:0] template9,
			// input [7:0] template10,
			// input [7:0] template11,
			// input [7:0] template12,
			// input [7:0] template13,
			// input [7:0] template14,
			// input [7:0] template15,
			// input [7:0] sig0,
			// input [7:0] sig1,
			// input [7:0] sig2,
			// input [7:0] sig3,
			// input [7:0] sig4,
			// input [7:0] sig5,
			// input [7:0] sig6,
			// input [7:0] sig7,
			// input [7:0] sig8,
			// input [7:0] sig9,
			// input [7:0] sig10,
			// input [7:0] sig11,
			// input [7:0] sig12,
			// input [7:0] sig13,
			// input [7:0] sig14,
			// input [7:0] sig15,
			// output [31:0] sum);
	
	// wire signed [15:0] result[0:15];
	
	// assign result[0] = template0 * sig0;
	// assign result[1] = template1 * sig1;
	// assign result[2] = template2 * sig2;
	// assign result[3] = template3 * sig3;
	// assign result[4] = template4 * sig4;
	// assign result[5] = template5 * sig5;
	// assign result[6] = template6 * sig6;
	// assign result[7] = template7 * sig7;
	// assign result[8] = template8 * sig8;
	// assign result[9] = template9 * sig9;
	// assign result[10] = template10 * sig10;
	// assign result[11] = template11 * sig11;
	// assign result[12] = template12 * sig12;
	// assign result[13] = template13 * sig13;
	// assign result[14] = template14 * sig14;
	// assign result[15] = template15 * sig15;
	// assign sum = result[0] +result[1] +result[2] +result[3] +result[4] +result[5] +result[6] +result[7] +
	// result[8] +result[9] +result[10] +result[11] +result[12] +result[13] +result[14] +result[15];
	
// endmodule
		
