`define NM1 32'd523 //C_freq
`define NM2 32'd587 //D_freq
`define NM3 32'd659 //E_freq
`define NM4 32'd698 //F_freq
`define NM5 32'd784 //G_freq
`define NM6 32'd880 //A_freq
`define NM7 32'd988 //B_freq
`define NM0 32'd20000 //slience (over freq.)
`define NMd 32'd55
`define NMm 32'd110
`define NMs 32'd220

module music(ibeatNum, tone, beat);
	input [9:0] ibeatNum;
	output reg [31:0] tone, beat;

	always @(*) begin
		case (ibeatNum)
			//1
			10'd0 :begin tone = `NM0; beat = `NMd; end
			10'd1 :begin tone = `NM0; beat = `NM0; end
			10'd2 :begin tone = `NM3; beat = `NM0; end
			10'd3 :begin tone = `NM3; beat = `NM0; end
			10'd4 :begin tone = `NM2; beat = `NMd; end
			10'd5 :begin tone = `NM2; beat = `NM0; end
			10'd6 :begin tone = `NM3; beat = `NM0; end
			10'd7 :begin tone = `NM3; beat = `NM0; end
			//2
			10'd8 :begin tone = `NM1; beat = `NMd; end
			10'd9 :begin tone = `NM1; beat = `NM0; end
			10'd10 :begin tone = `NM6>>1; beat = `NM0; end
			10'd11 :begin tone = `NM6>>1; beat = `NM0; end
			10'd12 :begin tone = `NM0; beat = `NMd; end
			10'd13 :begin tone = `NM0; beat = `NM0; end
			10'd14 :begin tone = `NM0; beat = `NM0; end
			10'd15 :begin tone = `NM0; beat = `NM0; end
			//3
			10'd16 :begin tone = `NM0; beat = `NMd; end
			10'd17 :begin tone = `NM0; beat = `NM0; end
			10'd18 :begin tone = `NM6>>1; beat = `NM0; end
			10'd19 :begin tone = `NM6>>1; beat = `NM0; end
			10'd20 :begin tone = `NM6>>1; beat = `NMd; end
			10'd21 :begin tone = `NM6>>1; beat = `NM0; end
			10'd22 :begin tone = `NM5>>1; beat = `NM0; end
			10'd23 :begin tone = `NM5>>1; beat = `NM0; end
			//4
			10'd24 :begin tone = `NM6>>1; beat = `NMd; end
			10'd25 :begin tone = `NM6>>1; beat = `NM0; end
			10'd26 :begin tone = `NM1; beat = `NM0; end
			10'd27 :begin tone = `NM1; beat = `NM0; end
			10'd28 :begin tone = `NM0; beat = `NMd; end
			10'd29 :begin tone = `NM0; beat = `NM0; end
			10'd30 :begin tone = `NM2; beat = `NM0; end
			10'd31 :begin tone = `NM2; beat = `NM0; end
			//5
			10'd32 :begin tone = `NM2; beat = `NMd; end
			10'd33 :begin tone = `NM2; beat = `NM0; end
			10'd34 :begin tone = `NM3; beat = `NM0; end
			10'd35 :begin tone = `NM3; beat = `NM0; end
			10'd36 :begin tone = `NM1; beat = `NMd; end
			10'd37 :begin tone = `NM1; beat = `NM0; end
			10'd38 :begin tone = `NM6>>1; beat = `NM0; end
			10'd39 :begin tone = `NM6>>1; beat = `NM0; end
			//6
			10'd40 :begin tone = `NM0; beat = `NMd; end
			10'd41 :begin tone = `NM0; beat = `NM0; end
			10'd42 :begin tone = `NM0; beat = `NM0; end
			10'd43 :begin tone = `NM0; beat = `NM0; end
			10'd44 :begin tone = `NM0; beat = `NMd; end
			10'd45 :begin tone = `NM0; beat = `NM0; end
			10'd46 :begin tone = `NM6>>1; beat = `NM0; end
			10'd47 :begin tone = `NM6>>1; beat = `NM0; end
			//7
			10'd48 :begin tone = `NM6>>1; beat = `NMd; end
			10'd49 :begin tone = `NM6>>1; beat = `NM0; end
			10'd50 :begin tone = `NM5>>1; beat = `NM0; end
			10'd51 :begin tone = `NM5>>1; beat = `NM0; end
			10'd52 :begin tone = `NM1; beat = `NMd; end
			10'd53 :begin tone = `NM1; beat = `NM0; end
			10'd54 :begin tone = `NM6>>1; beat = `NM0; end
			10'd55 :begin tone = `NM6>>1; beat = `NM0; end
			//8
			10'd56 :begin tone = `NM0; beat = `NMd; end
			10'd57 :begin tone = `NM0; beat = `NM0; end
			10'd58 :begin tone = `NM0; beat = `NM0; end
			10'd59 :begin tone = `NM0; beat = `NM0; end
			10'd60 :begin tone = `NM0; beat = `NMd; end
			10'd61 :begin tone = `NM0; beat = `NM0; end
			10'd62 :begin tone = `NM2; beat = `NM0; end
			10'd63 :begin tone = `NM2; beat = `NM0; end
			//9
			10'd64 :begin tone = `NM2; beat = `NMd; end
			10'd65 :begin tone = `NM2; beat = `NM0; end
			10'd66 :begin tone = `NM3; beat = `NM0; end
			10'd67 :begin tone = `NM3; beat = `NM0; end
			10'd68 :begin tone = `NM1; beat = `NMd; end
			10'd69 :begin tone = `NM1; beat = `NM0; end
			10'd70 :begin tone = `NM6>>1; beat = `NM0; end
			10'd71 :begin tone = `NM6>>1; beat = `NM0; end
			//10
			10'd72 :begin tone = `NM0; beat = `NMd; end
			10'd73 :begin tone = `NM0; beat = `NM0; end
			10'd74 :begin tone = `NM0; beat = `NM0; end
			10'd75 :begin tone = `NM0; beat = `NM0; end
			10'd76 :begin tone = `NM0; beat = `NMd; end
			10'd77 :begin tone = `NM0; beat = `NM0; end
			10'd78 :begin tone = `NM6>>1; beat = `NM0; end
			10'd79 :begin tone = `NM6>>1; beat = `NM0; end
			//11
			10'd80 :begin tone = `NM6>>1; beat = `NMd; end
			10'd81 :begin tone = `NM6>>1; beat = `NM0; end
			10'd82 :begin tone = `NM5>>1; beat = `NM0; end
			10'd83 :begin tone = `NM5>>1; beat = `NM0; end
			10'd84 :begin tone = `NM6>>1; beat = `NMd; end
			10'd85 :begin tone = `NM6>>1; beat = `NM0; end
			10'd86 :begin tone = `NM1; beat = `NM0; end
			10'd87 :begin tone = `NM1; beat = `NM0; end
			//12
			10'd88 :begin tone = `NM0; beat = `NMd; end
			10'd89 :begin tone = `NM0; beat = `NM0; end
			10'd90 :begin tone = `NM0; beat = `NM0; end
			10'd91 :begin tone = `NM0; beat = `NM0; end
			10'd92 :begin tone = `NM0; beat = `NMd; end
			10'd93 :begin tone = `NM0; beat = `NM0; end
			10'd94 :begin tone = `NM2; beat = `NM0; end
			10'd95 :begin tone = `NM2; beat = `NM0; end
			//13
			10'd96 :begin tone = `NM2; beat = `NMd; end
			10'd97 :begin tone = `NM2; beat = `NM0; end
			10'd98 :begin tone = `NM1; beat = `NM0; end
			10'd99 :begin tone = `NM1; beat = `NM0; end
			10'd100 :begin tone = `NM6>>1; beat = `NMd; end
			10'd101 :begin tone = `NM6>>1; beat = `NM0; end
			10'd102 :begin tone = `NM6>>1; beat = `NM0; end
			10'd103 :begin tone = `NM6>>1; beat = `NM0; end
			//14
			10'd104 :begin tone = `NM6>>1; beat = `NMd; end
			10'd105 :begin tone = `NM6>>1; beat = `NM0; end
			10'd106 :begin tone = `NM5>>1; beat = `NM0; end
			10'd107 :begin tone = `NM5>>1; beat = `NM0; end
			10'd108 :begin tone = `NM6>>1; beat = `NMd; end
			10'd109 :begin tone = `NM6>>1; beat = `NM0; end
			10'd110 :begin tone = `NM6>>1; beat = `NM0; end
			10'd111 :begin tone = `NM6>>1; beat = `NM0; end
			//15
			10'd112 :begin tone = `NM5>>1; beat = `NMd; end
			10'd113 :begin tone = `NM5>>1; beat = `NM0; end
			10'd114 :begin tone = `NM6>>1; beat = `NM0; end
			10'd115 :begin tone = `NM6>>1; beat = `NM0; end
			10'd116 :begin tone = `NM0; beat = `NMd; end
			10'd117 :begin tone = `NM0; beat = `NM0; end
			10'd118 :begin tone = `NM0; beat = `NM0; end
			10'd119 :begin tone = `NM0; beat = `NM0; end
			//16
			10'd120 :begin tone = `NM1; beat = `NMd; end
			10'd121 :begin tone = `NM1; beat = `NM0; end
			10'd122 :begin tone = `NM2; beat = `NM0; end
			10'd123 :begin tone = `NM2; beat = `NM0; end
			10'd124 :begin tone = `NM0; beat = `NMd; end
			10'd125 :begin tone = `NM0; beat = `NM0; end
			10'd126 :begin tone = `NM2; beat = `NM0; end
			10'd127 :begin tone = `NM2; beat = `NM0; end
			//18
			10'd128 :begin tone = `NM2; beat = `NMd; end
			10'd129 :begin tone = `NM2; beat = `NM0; end
			10'd130 :begin tone = `NM2; beat = `NM0; end
			10'd131 :begin tone = `NM2; beat = `NM0; end
			10'd132 :begin tone = `NM1; beat = `NMd; end
			10'd133 :begin tone = `NM1; beat = `NM0; end
			10'd134 :begin tone = `NM6>>1; beat = `NM0; end
			10'd135 :begin tone = `NM6>>1; beat = `NM0; end
			//19
			10'd136 :begin tone = `NM0; beat = `NMd; end
			10'd137 :begin tone = `NM0; beat = `NM0; end
			10'd138 :begin tone = `NM0; beat = `NM0; end
			10'd139 :begin tone = `NM0; beat = `NM0; end	
			//20
			10'd140 :begin tone = `NM0; beat = `NMd; end
			10'd141 :begin tone = `NM0; beat = `NM0; end
			10'd142 :begin tone = `NM6>>1; beat = `NM0; end
			10'd143 :begin tone = `NM6>>1; beat = `NM0; end
			10'd144 :begin tone = `NM6>>1; beat = `NMd; end
			10'd145 :begin tone = `NM6>>1; beat = `NM0; end
			10'd146 :begin tone = `NM5>>1; beat = `NM0; end
			10'd147 :begin tone = `NM5>>1; beat = `NM0; end
			//21
			10'd148 :begin tone = `NM6>>1; beat = `NMd; end
			10'd149 :begin tone = `NM0; beat = `NM0; end
			10'd150 :begin tone = `NM1; beat = `NM0; end
			10'd151 :begin tone = `NM1; beat = `NM0; end
			10'd152 :begin tone = `NM0; beat = `NMd; end
			10'd153 :begin tone = `NM0; beat = `NM0; end
			10'd154 :begin tone = `NM0; beat = `NM0; end
			10'd155 :begin tone = `NM0; beat = `NM0; end
			//22
			10'd156 :begin tone = `NM0; beat = `NMd; end
			10'd157 :begin tone = `NM0; beat = `NM0; end
			10'd158 :begin tone = `NM2; beat = `NM0; end
			10'd159 :begin tone = `NM2; beat = `NM0; end
			10'd160 :begin tone = `NM2; beat = `NMd; end
			10'd161 :begin tone = `NM2; beat = `NM0; end
			10'd162 :begin tone = `NM3; beat = `NM0; end
			10'd163 :begin tone = `NM3; beat = `NM0; end
			//23
			10'd164 :begin tone = `NM1; beat = `NMd; end
			10'd165 :begin tone = `NM1; beat = `NM0; end
			10'd166 :begin tone = `NM6>>1; beat = `NM0; end
			10'd167 :begin tone = `NM6>>1; beat = `NM0; end
			10'd168 :begin tone = `NM0; beat = `NMd; end
			10'd169 :begin tone = `NM0; beat = `NM0; end
			10'd170 :begin tone = `NM0; beat = `NM0; end
			10'd171 :begin tone = `NM0; beat = `NM0; end
			//24
			10'd172 :begin tone = `NM0; beat = `NMd; end
			10'd173 :begin tone = `NM0; beat = `NM0; end
			10'd174 :begin tone = `NM2; beat = `NM0; end
			10'd175 :begin tone = `NM2; beat = `NM0; end
			10'd176 :begin tone = `NM2; beat = `NMd; end
			10'd177 :begin tone = `NM2; beat = `NM0; end
			10'd178 :begin tone = `NM3; beat = `NM0; end
			10'd179 :begin tone = `NM3; beat = `NM0; end
			//25
			10'd180 :begin tone = `NM1; beat = `NMd; end
			10'd181 :begin tone = `NM1; beat = `NM0; end
			10'd182 :begin tone = `NM6>>1; beat = `NM0; end
			10'd183 :begin tone = `NM6>>1; beat = `NM0; end
			10'd184 :begin tone = `NM0; beat = `NMd; end
			10'd185 :begin tone = `NM0; beat = `NM0; end
			10'd186 :begin tone = `NM0; beat = `NM0; end
			10'd187 :begin tone = `NM0; beat = `NM0; end
			//26
			10'd188 :begin tone = `NM0; beat = `NMd; end
			10'd189 :begin tone = `NM0; beat = `NM0; end
			10'd190 :begin tone = `NM6>>1; beat = `NM0; end
			10'd191 :begin tone = `NM6>>1; beat = `NM0; end
			10'd192 :begin tone = `NM6>>1; beat = `NMd; end
			10'd193 :begin tone = `NM6>>1; beat = `NM0; end
			10'd194 :begin tone = `NM5>>1; beat = `NM0; end
			10'd195 :begin tone = `NM5>>1; beat = `NM0; end
			//27
			10'd196 :begin tone = `NM1; beat = `NMd; end
			10'd197 :begin tone = `NM1; beat = `NM0; end
			10'd198 :begin tone = `NM6>>1; beat = `NM0; end
			10'd199 :begin tone = `NM6>>1; beat = `NM0; end
			10'd200 :begin tone = `NM0; beat = `NMd; end
			10'd201 :begin tone = `NM0; beat = `NM0; end
			10'd202 :begin tone = `NM0; beat = `NM0; end
			10'd203 :begin tone = `NM0; beat = `NM0; end
			//28
			10'd204 :begin tone = `NM0; beat = `NMd; end
			10'd205 :begin tone = `NM0; beat = `NM0; end
			10'd206 :begin tone = `NM2; beat = `NM0; end
			10'd207 :begin tone = `NM2; beat = `NM0; end
			10'd208 :begin tone = `NM2; beat = `NMd; end
			10'd209 :begin tone = `NM2; beat = `NM0; end
			10'd210 :begin tone = `NM3; beat = `NM0; end
			10'd211 :begin tone = `NM3; beat = `NM0; end
			//29
			10'd212 :begin tone = `NM1; beat = `NMd; end
			10'd213 :begin tone = `NM1; beat = `NM0; end
			10'd214 :begin tone = `NM1; beat = `NM0; end
			10'd215 :begin tone = `NM6>>1; beat = `NM0; end
			10'd216 :begin tone = `NM0; beat = `NMd; end
			10'd217 :begin tone = `NM0; beat = `NM0; end
			10'd218 :begin tone = `NM0; beat = `NM0; end
			10'd219 :begin tone = `NM0; beat = `NM0; end
			//30
			10'd220 :begin tone = `NM0; beat = `NMd; end
			10'd221 :begin tone = `NM0; beat = `NM0; end
			10'd222 :begin tone = `NM6>>1; beat = `NM0; end
			10'd223 :begin tone = `NM6>>1; beat = `NM0; end
			10'd224 :begin tone = `NM6>>1; beat = `NMd; end
			10'd225 :begin tone = `NM6>>1; beat = `NM0; end
			10'd226 :begin tone = `NM5>>1; beat = `NM0; end
			10'd227 :begin tone = `NM5>>1; beat = `NM0; end
			//31
			10'd228 :begin tone = `NM6>>1; beat = `NMd; end
			10'd229 :begin tone = `NM6>>1; beat = `NM0; end
			10'd230 :begin tone = `NM1; beat = `NM0; end
			10'd231 :begin tone = `NM1; beat = `NM0; end
			10'd232 :begin tone = `NM0; beat = `NMd; end
			10'd233 :begin tone = `NM0; beat = `NM0; end
			10'd234 :begin tone = `NM0; beat = `NM0; end
			10'd235 :begin tone = `NM0; beat = `NM0; end
			//32
			10'd236 :begin tone = `NM0; beat = `NMd; end
			10'd237 :begin tone = `NM0; beat = `NM0; end
			10'd238 :begin tone = `NM3; beat = `NM0; end
			10'd239 :begin tone = `NM3; beat = `NM0; end
			10'd240 :begin tone = `NM2; beat = `NMd; end
			10'd241 :begin tone = `NM2; beat = `NM0; end
			10'd242 :begin tone = `NM1; beat = `NM0; end
			10'd243 :begin tone = `NM1; beat = `NM0; end
			//33
			10'd244 :begin tone = `NM6>>1; beat = `NMd; end
			10'd245 :begin tone = `NM6>>1; beat = `NM0; end
			10'd246 :begin tone = `NM6>>1; beat = `NM0; end
			10'd247 :begin tone = `NM6>>1; beat = `NM0; end
			10'd248 :begin tone = `NM6>>1; beat = `NMd; end
			10'd249 :begin tone = `NM6>>1; beat = `NM0; end
			10'd250 :begin tone = `NM5>>1; beat = `NM0; end
			10'd251 :begin tone = `NM5>>1; beat = `NM0; end
			//34
			10'd252 :begin tone = `NM6>>1; beat = `NMd; end
			10'd253 :begin tone = `NM6>>1; beat = `NM0; end
			10'd254 :begin tone = `NM6>>1; beat = `NM0; end
			10'd255 :begin tone = `NM6>>1; beat = `NM0; end
			10'd256 :begin tone = `NM5>>1; beat = `NMd; end
			10'd257 :begin tone = `NM5>>1; beat = `NM0; end
			10'd258 :begin tone = `NM6>>1; beat = `NM0; end
			10'd259 :begin tone = `NM6>>1; beat = `NM0; end
			//34
			10'd260 :begin tone = `NM0; beat = `NMd; end
			10'd261 :begin tone = `NM0; beat = `NM0; end
			10'd262 :begin tone = `NM6>>1; beat = `NM0; end
			10'd263 :begin tone = `NM6>>1; beat = `NM0; end
			10'd264 :begin tone = `NM0; beat = `NMd; end
			10'd265 :begin tone = `NM0; beat = `NM0; end
			10'd266 :begin tone = `NM6>>1; beat = `NM0; end
			10'd267 :begin tone = `NM6>>1; beat = `NM0; end
			//35
			10'd268 :begin tone = `NM0; beat = `NMm; end
			10'd269 :begin tone = `NM0; beat = `NM0; end
			10'd270 :begin tone = `NM6>>1; beat = `NM0; end
			10'd271 :begin tone = `NM6>>1; beat = `NM0; end
			10'd272 :begin tone = `NM6>>1; beat = `NMm; end
			10'd273 :begin tone = `NM6>>1; beat = `NM0; end
			10'd274 :begin tone = `NM6>>1; beat = `NM0; end
			10'd275 :begin tone = `NM6>>1; beat = `NM0; end
			//36-1
			10'd276 :begin tone = `NM6>>1; beat = `NMm; end
			10'd277 :begin tone = `NM6>>1; beat = `NM0; end
			10'd278 :begin tone = `NM6>>1; beat = `NM0; end
			10'd279 :begin tone = `NM6>>1; beat = `NM0; end
			10'd280 :begin tone = `NM6>>1; beat = `NM0; end
			10'd281 :begin tone = `NM6>>1; beat = `NM0; end
			10'd282 :begin tone = `NM6>>1; beat = `NM0; end
			10'd283 :begin tone = `NM6>>1; beat = `NM0; end
			//37-2
			10'd284 :begin tone = `NM6>>1; beat = `NMm; end
			10'd285 :begin tone = `NM6>>1; beat = `NM0; end
			10'd286 :begin tone = `NM6>>1; beat = `NM0; end
			10'd287 :begin tone = `NM6>>1; beat = `NM0; end
			10'd288 :begin tone = `NM6>>1; beat = `NM0; end
			10'd289 :begin tone = `NM6>>1; beat = `NM0; end
			10'd290 :begin tone = `NM6>>1; beat = `NM0; end
			10'd291 :begin tone = `NM6>>1; beat = `NM0; end
			//38-3
			10'd292 :begin tone = `NM6>>1; beat = `NMm; end
			10'd293 :begin tone = `NM6>>1; beat = `NM0; end
			10'd294 :begin tone = `NM6>>1; beat = `NM0; end
			10'd295 :begin tone = `NM6>>1; beat = `NM0; end
			10'd296 :begin tone = `NM6>>1; beat = `NMm; end
			10'd297 :begin tone = `NM6>>1; beat = `NM0; end
			10'd298 :begin tone = `NM6>>1; beat = `NM0; end
			10'd299 :begin tone = `NM6>>1; beat = `NM0; end
			//39-4
			10'd300 :begin tone = `NM6>>1; beat = `NMm; end
			10'd301 :begin tone = `NM6>>1; beat = `NM0; end
			10'd302 :begin tone = `NM6>>1; beat = `NM0; end
			10'd303 :begin tone = `NM6>>1; beat = `NM0; end
			10'd304 :begin tone = `NM6>>1; beat = `NMm; end
			10'd305 :begin tone = `NM6>>1; beat = `NM0; end
			10'd306 :begin tone = `NM6>>1; beat = `NM0; end
			10'd307 :begin tone = `NM6>>1; beat = `NM0; end
			//40-5
			10'd308 :begin tone = `NM6>>1; beat = `NMm; end
			10'd309 :begin tone = `NM6>>1; beat = `NM0; end
			10'd310 :begin tone = `NM6>>1; beat = `NMm; end
			10'd311 :begin tone = `NM6>>1; beat = `NM0; end
			10'd312 :begin tone = `NM6>>1; beat = `NMm; end
			10'd313 :begin tone = `NM6>>1; beat = `NM0; end
			10'd314 :begin tone = `NM6>>1; beat = `NMm; end
			10'd315 :begin tone = `NM6>>1; beat = `NM0; end
			//41-6
			10'd316 :begin tone = `NM6>>1; beat = `NMm; end
			10'd317 :begin tone = `NM6>>1; beat = `NM0; end
			10'd318 :begin tone = `NM6>>1; beat = `NMm; end
			10'd319 :begin tone = `NM6>>1; beat = `NM0; end
			10'd320 :begin tone = `NM6>>1; beat = `NMm; end
			10'd321 :begin tone = `NM6>>1; beat = `NM0; end
			10'd322 :begin tone = `NM6>>1; beat = `NMm; end
			10'd323 :begin tone = `NM6>>1; beat = `NM0; end
			//42-7
			10'd324 :begin tone = `NM6>>1; beat = `NMm; end
			10'd325 :begin tone = `NM6>>1; beat = `NM0; end
			10'd326 :begin tone = `NM6>>1; beat = `NMm; end
			10'd327 :begin tone = `NM6>>1; beat = `NM0; end
			10'd328 :begin tone = `NM6>>1; beat = `NMm; end
			10'd329 :begin tone = `NM6>>1; beat = `NM0; end
			10'd330 :begin tone = `NM6>>1; beat = `NMm; end
			10'd331 :begin tone = `NM6>>1; beat = `NM0; end
			//43-8
			10'd332 :begin tone = `NM6>>1; beat = `NMm; end
			10'd333 :begin tone = `NM6>>1; beat = `NM0; end
			10'd334 :begin tone = `NM6>>1; beat = `NMm; end
			10'd335 :begin tone = `NM6>>1; beat = `NM0; end
			10'd336 :begin tone = `NM6>>1; beat = `NMm; end
			10'd337 :begin tone = `NM6>>1; beat = `NM0; end
			10'd338 :begin tone = `NM6>>1; beat = `NMm; end
			10'd339 :begin tone = `NM6>>1; beat = `NM0; end
			//44-9
			10'd340 :begin tone = `NM6>>1; beat = `NMm; end
			10'd341 :begin tone = `NM6>>1; beat = `NM0; end
			10'd342 :begin tone = `NM6>>1; beat = `NMm; end
			10'd343 :begin tone = `NM6>>1; beat = `NM0; end
			10'd344 :begin tone = `NM6>>1; beat = `NMm; end
			10'd345 :begin tone = `NM6>>1; beat = `NM0; end
			10'd346 :begin tone = `NM6>>1; beat = `NMm; end
			10'd347 :begin tone = `NM6>>1; beat = `NM0; end
			//45-10
			10'd348 :begin tone = `NM6>>1; beat = `NMm; end
			10'd349 :begin tone = `NM6>>1; beat = `NMs; end
			10'd350 :begin tone = `NM6>>1; beat = `NMm; end
			10'd351 :begin tone = `NM6>>1; beat = `NMs; end
			10'd352 :begin tone = `NM6>>1; beat = `NMm; end
			10'd353 :begin tone = `NM6>>1; beat = `NMs; end
			10'd354 :begin tone = `NM6>>1; beat = `NMm; end
			10'd355 :begin tone = `NM6>>1; beat = `NMs; end
			//46-11
			10'd356 :begin tone = `NM6>>1; beat = `NMm; end
			10'd357 :begin tone = `NM6>>1; beat = `NMs; end
			10'd358 :begin tone = `NM6>>1; beat = `NMm; end
			10'd359 :begin tone = `NM6>>1; beat = `NMs; end
			10'd360 :begin tone = `NM6>>1; beat = `NMm; end
			10'd361 :begin tone = `NM6>>1; beat = `NMs; end
			10'd362 :begin tone = `NM6>>1; beat = `NMm; end
			10'd363 :begin tone = `NM6>>1; beat = `NMs; end
			//47-12
			10'd364 :begin tone = `NM6>>1; beat = `NMm; end
			10'd365 :begin tone = `NM6>>1; beat = `NMs; end
			10'd366 :begin tone = `NM6>>1; beat = `NMm; end
			10'd367 :begin tone = `NM6>>1; beat = `NMs; end
			10'd368 :begin tone = `NM6>>1; beat = `NMm; end
			10'd369 :begin tone = `NM6>>1; beat = `NMs; end
			10'd370 :begin tone = `NM6>>1; beat = `NMm; end
			10'd371 :begin tone = `NM6>>1; beat = `NMs; end
			//48-13
			10'd372 :begin tone = `NM6>>1; beat = `NMm; end
			10'd373 :begin tone = `NM6>>1; beat = `NMm; end
			10'd374 :begin tone = `NM6>>1; beat = `NMm; end
			10'd375 :begin tone = `NM6>>1; beat = `NMm; end
			10'd376 :begin tone = `NM6>>1; beat = `NMm; end
			10'd377 :begin tone = `NM6>>1; beat = `NMm; end
			10'd378 :begin tone = `NM6>>1; beat = `NMm; end
			10'd379 :begin tone = `NM6>>1; beat = `NMm; end
			//49-14
			10'd380 :begin tone = `NM6>>1; beat = `NMm; end
			10'd381 :begin tone = `NM6>>1; beat = `NMm; end
			10'd382 :begin tone = `NM6>>1; beat = `NMm; end
			10'd383 :begin tone = `NM6>>1; beat = `NMm; end
			10'd384 :begin tone = `NM6>>1; beat = `NMm; end
			10'd385 :begin tone = `NM6>>1; beat = `NMm; end
			10'd386 :begin tone = `NM6>>1; beat = `NMm; end
			10'd387 :begin tone = `NM6>>1; beat = `NMm; end
			//50
			10'd388 :begin tone = `NM0; beat = `NMm; end
			10'd389 :begin tone = `NM0; beat = `NM0; end
			10'd390 :begin tone = `NM1; beat = `NM0; end
			10'd391 :begin tone = `NM1; beat = `NM0; end
			10'd392 :begin tone = `NM2; beat = `NMm; end
			10'd393 :begin tone = `NM2; beat = `NM0; end
			10'd394 :begin tone = `NM2; beat = `NM0; end
			10'd395 :begin tone = `NM2; beat = `NM0; end
			//51
			10'd396 :begin tone = `NM0; beat = `NMm; end
			10'd397 :begin tone = `NM0; beat = `NM0; end
			10'd398 :begin tone = `NM3; beat = `NM0; end
			10'd399 :begin tone = `NM3; beat = `NM0; end
			10'd400 :begin tone = `NM5; beat = `NMm; end
			10'd401 :begin tone = `NM5; beat = `NM0; end
			10'd402 :begin tone = `NM6; beat = `NM0; end
			10'd403 :begin tone = `NM6; beat = `NM0; end
			//52
			10'd404 :begin tone = `NM1<<1; beat = `NMm; end
			10'd405 :begin tone = `NM1<<1; beat = `NM0; end
			10'd406 :begin tone = `NM1<<1; beat = `NMm; end
			10'd407 :begin tone = `NM1<<1; beat = `NM0; end
			10'd408 :begin tone = `NM1<<1; beat = `NMm; end
			10'd409 :begin tone = `NM1<<1; beat = `NM0; end
			10'd410 :begin tone = `NM1<<1; beat = `NMm; end
			10'd411 :begin tone = `NM1<<1; beat = `NM0; end
			//53
			10'd412 :begin tone = `NM1<<1; beat = `NMm; end
			10'd413 :begin tone = `NM1<<1; beat = `NM0; end
			10'd414 :begin tone = `NM3; beat = `NMm; end
			10'd415 :begin tone = `NM3; beat = `NM0; end
			10'd416 :begin tone = `NM2; beat = `NMm; end
			10'd417 :begin tone = `NM2; beat = `NM0; end
			10'd418 :begin tone = `NM1; beat = `NMm; end
			10'd419 :begin tone = `NM1; beat = `NM0; end
			//54
			10'd420 :begin tone = `NM2; beat = `NMm; end
			10'd421 :begin tone = `NM2; beat = `NM0; end
			10'd422 :begin tone = `NM2; beat = `NM0; end
			10'd423 :begin tone = `NM2; beat = `NM0; end
			10'd424 :begin tone = `NM1; beat = `NM0; end
			10'd425 :begin tone = `NM1; beat = `NMm; end
			10'd426 :begin tone = `NM3; beat = `NM0; end
			10'd427 :begin tone = `NM3; beat = `NM0; end
			//55
			10'd428 :begin tone = `NM0; beat = `NMm; end
			10'd429 :begin tone = `NM0; beat = `NM0; end
			10'd430 :begin tone = `NM3; beat = `NM0; end
			10'd431 :begin tone = `NM3; beat = `NM0; end
			10'd432 :begin tone = `NM5; beat = `NMm; end
			10'd433 :begin tone = `NM5; beat = `NM0; end
			10'd434 :begin tone = `NM6; beat = `NM0; end
			10'd435 :begin tone = `NM6; beat = `NM0; end
			//56
			10'd436 :begin tone = `NM1<<1; beat = `NMm; end
			10'd437 :begin tone = `NM1<<1; beat = `NM0; end
			10'd438 :begin tone = `NM1<<1; beat = `NMm; end
			10'd439 :begin tone = `NM1<<1; beat = `NM0; end
			10'd440 :begin tone = `NM1<<1; beat = `NMm; end
			10'd441 :begin tone = `NM1<<1; beat = `NM0; end
			10'd442 :begin tone = `NM1<<1; beat = `NMm; end
			10'd443 :begin tone = `NM1<<1; beat = `NM0; end
			//57
			10'd444 :begin tone = `NM1<<1; beat = `NMm; end
			10'd445 :begin tone = `NM1<<1; beat = `NM0; end
			10'd446 :begin tone = `NM3; beat = `NMm; end
			10'd447 :begin tone = `NM3; beat = `NM0; end
			10'd448 :begin tone = `NM2; beat = `NMm; end
			10'd449 :begin tone = `NM2; beat = `NM0; end
			10'd450 :begin tone = `NM1; beat = `NMm; end
			10'd451 :begin tone = `NM1; beat = `NM0; end
			//58
			10'd452 :begin tone = `NM2; beat = `NMm; end
			10'd453 :begin tone = `NM2; beat = `NM0; end
			10'd454 :begin tone = `NM2; beat = `NMm; end
			10'd455 :begin tone = `NM2; beat = `NM0; end
			10'd456 :begin tone = `NM1; beat = `NMm; end
			10'd457 :begin tone = `NM1; beat = `NM0; end
			10'd458 :begin tone = `NM6>>1; beat = `NMm; end
			10'd459 :begin tone = `NM6>>1; beat = `NM0; end
			//59
			10'd460 :begin tone = `NM0; beat = `NMm; end
			10'd461 :begin tone = `NM0; beat = `NM0; end
			10'd462 :begin tone = `NM3; beat = `NMm; end
			10'd463 :begin tone = `NM3; beat = `NM0; end
			10'd464 :begin tone = `NM5; beat = `NMm; end
			10'd465 :begin tone = `NM5; beat = `NM0; end
			10'd466 :begin tone = `NM6; beat = `NMm; end
			10'd467 :begin tone = `NM6; beat = `NM0; end
			//60
			10'd468 :begin tone = `NM1<<1; beat = `NMm; end
			10'd469 :begin tone = `NM1<<1; beat = `NM0; end
			10'd470 :begin tone = `NM1<<1; beat = `NMm; end
			10'd471 :begin tone = `NM1<<1; beat = `NM0; end
			10'd472 :begin tone = `NM1<<1; beat = `NMm; end
			10'd473 :begin tone = `NM1<<1; beat = `NM0; end
			10'd474 :begin tone = `NM1<<1; beat = `NMm; end
			10'd475 :begin tone = `NM1<<1; beat = `NM0; end
			//61
			10'd476 :begin tone = `NM1<<1; beat = `NMm; end
			10'd477 :begin tone = `NM1<<1; beat = `NM0; end
			10'd478 :begin tone = `NM3; beat = `NMm; end
			10'd479 :begin tone = `NM3; beat = `NM0; end
			10'd480 :begin tone = `NM2; beat = `NMm; end
			10'd481 :begin tone = `NM2; beat = `NM0; end
			10'd482 :begin tone = `NM1; beat = `NM0; end
			10'd483 :begin tone = `NM1; beat = `NM0; end
			//62
			10'd484 :begin tone = `NM2; beat = `NMm; end
			10'd485 :begin tone = `NM2; beat = `NM0; end
			10'd486 :begin tone = `NM2; beat = `NM0; end
			10'd487 :begin tone = `NM2; beat = `NM0; end
			10'd488 :begin tone = `NM1; beat = `NMm; end
			10'd489 :begin tone = `NM1; beat = `NM0; end
			10'd490 :begin tone = `NM3; beat = `NM0; end
			10'd491 :begin tone = `NM3; beat = `NM0; end
			//63
			10'd492 :begin tone = `NM0; beat = `NMm; end
			10'd493 :begin tone = `NM0; beat = `NM0; end
			10'd494 :begin tone = `NM3; beat = `NM0; end
			10'd495 :begin tone = `NM3; beat = `NM0; end
			10'd496 :begin tone = `NM2; beat = `NMm; end
			10'd497 :begin tone = `NM2; beat = `NM0; end
			10'd498 :begin tone = `NM1; beat = `NM0; end
			10'd499 :begin tone = `NM1; beat = `NM0; end
			//63
			10'd500 :begin tone = `NM6>>1; beat = `NMm; end
			10'd501 :begin tone = `NM6>>1; beat = `NM0; end
			10'd502 :begin tone = `NM3; beat = `NMs; end
			10'd503 :begin tone = `NM3; beat = `NM0; end
			10'd504 :begin tone = `NM6>>1; beat = `NMm; end
			10'd505 :begin tone = `NM6>>1; beat = `NM0; end
			10'd506 :begin tone = `NM3; beat = `NMs; end
			10'd507 :begin tone = `NM3; beat = `NM0; end
			//64
			10'd508 :begin tone = `NM6>>1; beat = `NMm; end
			10'd509 :begin tone = `NM6>>1; beat = `NM0; end
			10'd510 :begin tone = `NM3; beat = `NMs; end
			10'd511 :begin tone = `NM3; beat = `NM0; end
			10'd512 :begin tone = `NM6>>1; beat = `NMm; end
			10'd513 :begin tone = `NM6>>1; beat = `NM0; end
			10'd514 :begin tone = `NM3; beat = `NMs; end
			10'd515 :begin tone = `NM3; beat = `NM0; end
			//65
			10'd516 :begin tone = `NM3; beat = `NMs; end
			10'd517 :begin tone = `NM2; beat = `NM0; end
			10'd518 :begin tone = `NM3; beat = `NMm; end
			10'd519 :begin tone = `NM3; beat = `NM0; end
			10'd520 :begin tone = `NM3; beat = `NMs; end
			10'd521 :begin tone = `NM2; beat = `NM0; end
			10'd522 :begin tone = `NM3; beat = `NMm; end
			10'd523 :begin tone = `NM3; beat = `NM0; end
			//65
			10'd524 :begin tone = `NM3; beat = `NMs; end
			10'd525 :begin tone = `NM2; beat = `NM0; end
			10'd526 :begin tone = `NM3; beat = `NMm; end
			10'd527 :begin tone = `NM3; beat = `NM0; end
			10'd528 :begin tone = `NM2; beat = `NMm; end
			10'd529 :begin tone = `NM2; beat = `NM0; end
			10'd530 :begin tone = `NM1; beat = `NMd; end
			10'd531 :begin tone = `NM1; beat = `NM0; end
			//66
			10'd532 :begin tone = `NM5>>1; beat = `NMd; end
			10'd533 :begin tone = `NM5>>1; beat = `NM0; end
			10'd534 :begin tone = `NM6>>1; beat = `NMm; end
			10'd535 :begin tone = `NM6>>1; beat = `NM0; end
			10'd536 :begin tone = `NM0; beat = `NM0; end
			10'd537 :begin tone = `NM0; beat = `NM0; end
			10'd538 :begin tone = `NM0; beat = `NM0; end
			10'd539 :begin tone = `NM0; beat = `NM0; end
			//67
			10'd540 :begin tone = `NM6>>1; beat = `NMs; end
			10'd541 :begin tone = `NM6>>1; beat = `NM0; end
			10'd542 :begin tone = `NM0; beat = `NMs; end
			10'd543 :begin tone = `NM6>>1; beat = `NM0; end
			10'd544 :begin tone = `NM6>>1; beat = `NMs; end
			10'd545 :begin tone = `NM6>>1; beat = `NM0; end
			10'd546 :begin tone = `NM6>>1; beat = `NMs; end
			10'd547 :begin tone = `NM6>>1; beat = `NM0; end
			//68
			10'd548 :begin tone = `NM6>>1; beat = `NMs; end
			10'd549 :begin tone = `NM6>>1; beat = `NM0; end
			10'd550 :begin tone = `NM0; beat = `NMs; end
			10'd551 :begin tone = `NM6>>1; beat = `NM0; end
			10'd552 :begin tone = `NM6>>1; beat = `NMs; end
			10'd553 :begin tone = `NM6>>1; beat = `NM0; end
			10'd554 :begin tone = `NM6>>1; beat = `NMs; end
			10'd555 :begin tone = `NM6>>1; beat = `NM0; end
			//69
			10'd556 :begin tone = `NM6>>1; beat = `NMs; end
			10'd557 :begin tone = `NM6>>1; beat = `NM0; end
			10'd558 :begin tone = `NM3; beat = `NMm; end
			10'd559 :begin tone = `NM3; beat = `NM0; end
			10'd560 :begin tone = `NM6>>1; beat = `NMs; end
			10'd561 :begin tone = `NM6>>1; beat = `NM0; end
			10'd562 :begin tone = `NM3; beat = `NMm; end
			10'd563 :begin tone = `NM3; beat = `NM0; end
			//69
			10'd556 :begin tone = `NM0; beat = `NMd; end
			10'd557 :begin tone = `NM0; beat = `NM0; end
			10'd558 :begin tone = `NM0; beat = `NMd; end
			10'd559 :begin tone = `NM0; beat = `NM0; end
			10'd560 :begin tone = `NM0; beat = `NMd; end
			10'd561 :begin tone = `NM0; beat = `NM0; end
			10'd562 :begin tone = `NM0; beat = `NMd; end
			10'd563 :begin tone = `NM0; beat = `NM0; end
			//70
			10'd564 :begin tone = `NM0; beat = `NMd; end
			10'd565 :begin tone = `NM0; beat = `NM0; end
			10'd566 :begin tone = `NM0; beat = `NMd; end
			10'd567 :begin tone = `NM0; beat = `NM0; end
			10'd568 :begin tone = `NM0; beat = `NMd; end
			10'd569 :begin tone = `NM0; beat = `NM0; end
			10'd570 :begin tone = `NM0; beat = `NMd; end
			10'd571 :begin tone = `NM0; beat = `NM0; end
			//71
			10'd572 :begin tone = `NM0; beat = `NMd; end
			10'd573 :begin tone = `NM0; beat = `NM0; end
			10'd574 :begin tone = `NM0; beat = `NMd; end
			10'd575 :begin tone = `NM0; beat = `NM0; end
			10'd576 :begin tone = `NM0; beat = `NMd; end
			10'd577 :begin tone = `NM0; beat = `NM0; end
			10'd578 :begin tone = `NM0; beat = `NMd; end
			10'd579 :begin tone = `NM0; beat = `NM0; end
			//72
			10'd580 :begin tone = `NM6>>1; beat = `NMs; end
			10'd581 :begin tone = `NM6>>1; beat = `NM0; end
			10'd582 :begin tone = `NM3; beat = `NMm; end
			10'd583 :begin tone = `NM3; beat = `NM0; end
			10'd584 :begin tone = `NM6>>1; beat = `NMs; end
			10'd585 :begin tone = `NM6>>1; beat = `NM0; end
			10'd586 :begin tone = `NM3; beat = `NMm; end
			10'd587 :begin tone = `NM3; beat = `NM0; end
			//73
			10'd588 :begin tone = `NM6>>1; beat = `NMs; end
			10'd589 :begin tone = `NM6>>1; beat = `NM0; end
			10'd590 :begin tone = `NM0; beat = `NMs; end
			10'd591 :begin tone = `NM6>>1; beat = `NM0; end
			10'd592 :begin tone = `NM6>>1; beat = `NMs; end
			10'd593 :begin tone = `NM6>>1; beat = `NM0; end
			10'd594 :begin tone = `NM6>>1; beat = `NMs; end
			10'd595 :begin tone = `NM6>>1; beat = `NM0; end
			//74
			10'd596 :begin tone = `NM6>>1; beat = `NMs; end
			10'd597 :begin tone = `NM6>>1; beat = `NM0; end
			10'd598 :begin tone = `NM0; beat = `NMs; end
			10'd599 :begin tone = `NM6>>1; beat = `NM0; end
			10'd600 :begin tone = `NM6>>1; beat = `NMs; end
			10'd601 :begin tone = `NM6>>1; beat = `NM0; end
			10'd602 :begin tone = `NM6>>1; beat = `NMs; end
			10'd603 :begin tone = `NM6>>1; beat = `NM0; end
			//75
			10'd604 :begin tone = `NM6>>1; beat = `NMs; end
			10'd605 :begin tone = `NM6>>1; beat = `NM0; end
			10'd606 :begin tone = `NM0; beat = `NMs; end
			10'd607 :begin tone = `NM6>>1; beat = `NM0; end
			10'd608 :begin tone = `NM6>>1; beat = `NMs; end
			10'd609 :begin tone = `NM6>>1; beat = `NM0; end
			10'd610 :begin tone = `NM6>>1; beat = `NMs; end
			10'd611 :begin tone = `NM6>>1; beat = `NM0; end
			//76
			10'd612 :begin tone = `NM3; beat = `NMs; end
			10'd613 :begin tone = `NM3; beat = `NM0; end
			10'd614 :begin tone = `NM2; beat = `NMm; end
			10'd615 :begin tone = `NM2; beat = `NM0; end
			10'd616 :begin tone = `NM3; beat = `NMs; end
			10'd617 :begin tone = `NM3; beat = `NM0; end
			10'd618 :begin tone = `NM2; beat = `NMm; end
			10'd619 :begin tone = `NM2; beat = `NM0; end
			//77
			10'd620 :begin tone = `NM6>>1; beat = `NMs; end
			10'd621 :begin tone = `NM6>>1; beat = `NM0; end
			10'd622 :begin tone = `NM0; beat = `NMs; end
			10'd623 :begin tone = `NM6>>1; beat = `NM0; end
			10'd624 :begin tone = `NM6>>1; beat = `NMs; end
			10'd625 :begin tone = `NM6>>1; beat = `NM0; end
			10'd626 :begin tone = `NM6>>1; beat = `NMs; end
			10'd627 :begin tone = `NM6>>1; beat = `NM0; end
			//78
			10'd628 :begin tone = `NM6>>1; beat = `NMs; end
			10'd629 :begin tone = `NM6>>1; beat = `NM0; end
			10'd630 :begin tone = `NM0; beat = `NMs; end
			10'd631 :begin tone = `NM6>>1; beat = `NM0; end
			10'd632 :begin tone = `NM6>>1; beat = `NMs; end
			10'd633 :begin tone = `NM6>>1; beat = `NM0; end
			10'd634 :begin tone = `NM6>>1; beat = `NMs; end
			10'd635 :begin tone = `NM6>>1; beat = `NM0; end
			//78
			10'd636 :begin tone = `NM6>>1; beat = `NMs; end
			10'd637 :begin tone = `NM6>>1; beat = `NM0; end
			10'd638 :begin tone = `NM0; beat = `NMs; end
			10'd639 :begin tone = `NM6>>1; beat = `NM0; end
			10'd640 :begin tone = `NM6>>1; beat = `NMs; end
			10'd641 :begin tone = `NM6>>1; beat = `NM0; end
			10'd642 :begin tone = `NM6>>1; beat = `NMs; end
			10'd643 :begin tone = `NM6>>1; beat = `NM0; end
			
			default :begin tone = `NM0; beat = `NM0; end
		endcase
	end

endmodule