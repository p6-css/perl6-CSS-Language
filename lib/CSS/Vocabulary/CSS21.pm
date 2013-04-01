use v6;

# specification: http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html

use CSS::Vocabulary::CSS1;

grammar CSS::Vocabulary::CSS21:ver<20110607.000> 
    is CSS::Vocabulary::CSS1 {

    rule decl:sym<azimuth> {:i (azimuth) ':' [
                                 <angle>
                                 | [[$<lr>=[ left\-side | far\-left | left | center\-left | center | center\-right | right | far\-right | right\-side ] $<bh>='behind'? | $<bh>=behind ]]
                                 | $<delta>=[$<dl>=leftwards | $<dr>=rightwards]
                                 | <inherit> || <bad_args> ]}

    rule decl:sym<elevation> {:i (elevation) ':' [
                                   <angle>
                                   | $<tilt>=[below | level | above]
                                   | $<delta>=[ $<dh>=higher | $<dl>=lower ]
                                   | <inherit> || <bad_args> ]}

}
