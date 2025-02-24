DECLARE 
  xact_no account.act_no%TYPE;
  xact_balance account.act_balance%TYPE;
  opt NUMBER(1); 
  deposit NUMBER(10);
  withdrawal NUMBER(10);

BEGIN
  xact_no := :Enter_Account_Number;
  opt := :ENTER_OPTION;  

  SELECT act_balance INTO xact_balance 
  FROM account
  WHERE act_no = xact_no; 
  
  IF opt = 1 THEN
    deposit := :Enter_Deposit_Amount;
    UPDATE account
    SET act_balance = act_balance + deposit
    WHERE act_no = xact_no; 

    xact_balance := xact_balance + deposit;
    DBMS_OUTPUT.PUT_LINE('Rs. ' || deposit || ' has been credited in your account');
    DBMS_OUTPUT.PUT_LINE('Your final balance is Rs. ' || xact_balance);
                          
  ELSIF opt = 2 THEN 
    withdrawal := :Enter_Withdrawal_Amount;
    
    IF withdrawal <= xact_balance THEN
      UPDATE account
      SET act_balance = act_balance - withdrawal
      WHERE act_no = xact_no;
    
      xact_balance := xact_balance - withdrawal;
      DBMS_OUTPUT.PUT_LINE('Rs. ' || withdrawal || ' has been debited in your account');
      DBMS_OUTPUT.PUT_LINE('Your final balance is Rs.' || xact_balance);
    
    ELSE
      DBMS_OUTPUT.PUT_LINE('Your withdrawal amount is greater than balance');
      DBMS_OUTPUT.PUT_LINE('Your transaction failed');
      DBMS_OUTPUT.PUT_LINE('Your final balance is Rs.' || xact_balance); 
    END IF;
    
  ELSE
    DBMS_OUTPUT.PUT_LINE('Your balance is Rs. ' || xact_balance);
  END IF;

END;
/
