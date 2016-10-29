// http://forum.openscad.org/parameterized-models-td8303.html

wrench_default = ["len", 10, "w", 2, "color", "red"];

function hash(h, k, _i_=0) = ( 
    _i_>len(h)-1 ? undef  // key not found 
    : h[_i_]==k ?    // key found 
    h[_i_+1]  // return v 
    : hash(h,k,_i_+2)           
    );

//echo(hash(wrench_default, "len"));

module Wrench( op = wrench_default){ 
    myop = concat( op,              // user-input ops                                               
                  [ "len", 10  , "w", 2, "color", "red"]    // wrench_default 
        ); 
    function ops(k) = hash( myop, k);   
    l = ops("len");
    w = ops("w");
    echo("Wrench");
    echo(l=l);
    echo(w=w);
} 

module Wrench_1( op ){ 
    myop = concat( [ "len", 12 ],    //-- Wrench_1-specific default 
                  op //-- user-input ops for Wrench_1 
        ); 
    Wrench( myop );    // calling the "mother wrench", in which this Wrench_1_ops 
    function ops(k) = hash( myop, k);   
    // is passed to "update" the wrench_default of mother wrench. 
    l = ops("len");
    w = ops("w");
    echo("Wrench_1");
    echo(l=l);
    echo(w=w);
}

module Wrench_grandkid( grandkid_ops ){ 
    grandkid_ops = concat(  [ "w", 1 ]      //-- grandkid-specific default 
                            ,  grandkid_ops //-- user-input ops for grandkid 
        ); 
    Wrench_1( grandkid_ops );   
    function ops(k) = hash( grandkid_ops, k);   
    l = ops("len");
    w = ops("w");
    echo("Wrench_grandkid");
    echo(l=l);
    echo(w=w);
} 

Wrench_grandkid();
