import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";



actor Token {
  var owner : Principal = Principal.fromText("734gs-biopx-zi2b5-eehhe-lktnh-veghr-7u3et-3w5tv-is5b7-xczhe-dae");
  var totalSupply :Nat = 1000000000;
  var symbol :Text = "DANH";
  var balances = HashMap.HashMap<Principal,Nat>(1,Principal.equal,Principal.hash);
  balances.put(owner,totalSupply);



  public query func balanceOf(who:Principal):async Nat{

    let balance :Nat = switch(balances.get(who)){
      case null 0;
      case(?result) result ;
    };
    return balance
  };
  public query func getSymbol():async Text{
    return symbol;
  };

  public shared(msg) func payOut(): async Text{

    Debug.print(debug_show(msg.caller));
    if(balances.get(msg.caller)==null) {
    let amount = 10000;
    let result = await transfer(msg.caller,amount);
    return result;
    }else{
      return "Alredy Claimed"
    };

   
    // return "Success";
  };
  public shared(msg) func transfer(to:Principal ,amount:Nat): async Text{
    let fromBalance = await balanceOf(msg.caller);
    if(fromBalance > amount){
      let newFromBalance :Nat = fromBalance - amount;
      balances.put(msg.caller,newFromBalance);

      let toBalance = await balanceOf(to);
      let newTobalance = toBalance + amount ;
      balances.put(to,newTobalance);
      return "Success" ;
    }else{
      return "Insufficient Funds"
    };

  }
};
