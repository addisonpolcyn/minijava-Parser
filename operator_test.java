/*
* This Program compiles for both java and minijava+
* To check for operator correctness pass all test cases by compiling with minijava
* all cases should PASS
*/
class operator_test {
    public static void main(String [] args) {
        {
        //start test
        System.out.println("Operator Test");
        
        //boolean ops
        System.out.println("Test #1: &&");
        if(true && true) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(true && false) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(false && true) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(false && false) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        System.out.println("Test #2: ||");
        if(true || true) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(true || false) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(false || true) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(false || false) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        System.out.println("Test #3: ==");
        if(true == true) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(false == true) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        System.out.println("Test #4: !=");
        if(true != true) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(false != true) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }

        //comparators
        System.out.println("Test #5: <");
        if(-1 < 1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(1 < -1) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(1 < 1) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        System.out.println("Test #6: <=");
        if(-1 <= 1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(1 <= -1) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(1 <= 1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #7: >");
        if(1 > -1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(-1 > 1) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(1 > 1) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        System.out.println("Test #8: >=");
        if(1 >= -1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(-1 >= 1) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }
        if(1 >= 1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }

        //ops
        System.out.println("Test #9: +");
        if(1+1==2) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(0+10==10) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(-5+5==0) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #10: -");
        if(4-2==2) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(10-0==10) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(-5-5==-10) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #11: *");
        if(1*1==1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(0*1==0) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(-5*-5==25) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }

        //booleans
        System.out.println("Test #12: true");
        if(true) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #13: false");
        if(false) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }

        //not
        System.out.println("Test #14: !");
        if(!false) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(!true) {
            System.out.println("FAILED");
        } else {
            System.out.println("PASSED");
        }

        //misc
        System.out.println("Test #15: Integer Literal");
        if(10 == 10) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #16: (+)");
        if(+1 == 1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(+(-1) == -1) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #17: (-)");
        if(-1 == -(1)) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        if(1 != -(1)) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }

        //combos
        System.out.println("Test #18: Robust");
        if((!true || !false) && true && 3*3==9) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #19: Robust");
        if(30 > 5 && true!=false && 3+3<10) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }
        System.out.println("Test #20: Robust");
        if(30 >= 30 && true && 15-5<=10) {
            System.out.println("PASSED");
        } else {
            System.out.println("FAILED");
        }

        }
    }
}
