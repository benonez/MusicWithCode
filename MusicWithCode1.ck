.01 => float left => float right;
7 => float fade => float fade_init;
Impulse left_out => dac.chan(0);
Impulse right_out => dac.chan(1);
SinOsc lfo => blackhole;
lfo.freq(.1);
while(1){
    Std.scalef(lfo.last(), -1.0, 1.0, 2, 7) => fade;
    if(Math.fabs(adc.chan(0).last()) < 1){
        left * fade => left;
        right * fade => right;
    }
    if(adc.chan(0).last() > 0){
        if(adc.chan(0).last() < left) adc.chan(0).last() => left;
    } else {
        if(adc.chan(0).last() > left) adc.chan(0).last() => left;
    }
    if(adc.chan(1).last() > 0){
        if(adc.chan(1).last() < right) adc.chan(1).last() => right;
    } else {
        if(adc.chan(1).last() > right) adc.chan(1).last() => right;
    }
    left_out.next( left );
    right_out.next( right );
    1::samp => now;
}