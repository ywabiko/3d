
function hash(h, k, _i_=0) = ( 
    _i_>len(h)-1 ? undef  // key not found 
    : h[_i_]==k ?    // key found 
    h[_i_+1]  // return v 
    : hash(h,k,_i_+2)           
    );

arm_defaults = [
    "size_x", 10,
    "size_y", 20,
    "size_z", 2,
    ];

holder_defaults = [
    "holder_x", hash(arm_defaults,"size_x")+2,
    "holder_y", hash(arm_defaults,"size_y")+2,
    "holder_z", hash(arm_defaults,"size_z")+2,
    ];

//arm(["size_x",33]);
holder(["holder_x",29]);

module arm(overrides=[]){
    echo("arm----");
    op = concat(overrides, arm_defaults);
    for (i=[0:1:len(op)-1]){
        x=op[i];
        echo(x=x);
    }
    p1 = hash(op,"size_x");
    echo (p1=p1);
}

module holder(overrides=[]){
    echo("holder----");
    op = concat(overrides, holder_defaults);
    for (i=[0:1:len(op)-1]){
        x=op[i];
        echo(x=x);
    }
    p1 = hash(op,"size_x");
    echo (p1=p1);

    arm(overrides);
}
