module coffeevending(clk,reset,amt,s5,s10,s15,s20,out);
    input [1:0]amt;
    input clk,reset;
    output reg s5,s10,s15,s20;
    output reg[3:0] out=3'b000;
    parameter idle=3'b000,sl5=3'b001,sl10=3'b010,sl15=3'b011,sl20=3'b100;
    reg [2:0]next_st;
    always@(posedge clk)
    begin
        if(!reset)
        begin
           next_st<=idle;
           s5<=0;
           s10<=0;
           s15<=0;
           s20<=0;
        end
        else
        begin
            case(next_st)
                idle:begin
                    if(amt==2'b00)
                    next_st<=sl5;
                    else if(amt==2'b01)
                    next_st<=sl10;
                    else if(amt==2'b10)
                    next_st<=sl15;
                    else if(amt==2'b11)
                    next_st<=sl20;
                end
                sl5:begin
                    s5<=1'b1;
                    if(amt==2'b00)
                    next_st<=sl10;
                    else if(amt==2'b01)
                    next_st<=sl15;
                    else
                    next_st<=idle;
                end
                sl10:begin
                    s10<=1'b1;
                    if(amt==2'b00)
                    next_st<=sl15;
                    else if(amt==2'b01)
                    next_st<=sl20;
                    else
                    next_st<=idle;
                end
                sl15:begin
                    s15<=1'b1;
                    if(amt==2'b00)
                    next_st<=sl20;
                    else
                    next_st<=idle;
                end
                sl20:begin
                    s20<=1'b1;
                    if(amt==2'b11)
                    next_st<=idle;
                end
        endcase 
        if(s20==1'b1)
        out<=out+1;
        end
end
endmodule