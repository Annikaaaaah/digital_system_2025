module wow();
    wire out;
    reg in;
    not #3 n0(out , in); //in changes first, displayed. out changes 3 units after, diplayed
    integer i;
    initial begin
        $display("time / in out");
        $monitor("%4d / %2b %3b" , $time , in , out);
        for(i = 0 ; i < 5 ; i = i + 1) begin
            $display("------- %1d -------" , i);
            in = i;
            #10;
        end
    end
endmodule
