import React,{useState} from "react";
import {token_backend} from "../../../declarations/token_backend"
import {Principal} from "@dfinity/principal"


function Transfer() {

  const [recipentId,setId]=useState("")
  const [amount,setAmount]=useState("")
  const [isDisabled,setDisabled]=useState(false)
  const [feedback,setFeedback]=useState("")
  const [isHidden,setHidden]=useState(true)

  
  async function handleClick() {
    setHidden(true)
    setDisabled(true)
    // console.log(recipentId);
    const recipient =  Principal.fromText(recipentId)
    const amountToTransfer = Number(amount)
    const result = await token_backend.transfer(recipient,amountToTransfer)
    setFeedback(result)
    setHidden(false)
    setDisabled(false)
    // console.log("tranfer button clicked",recipient);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recipentId}
                onChange={(e)=>setId(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e)=>setAmount(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isDisabled} >
            Transfer
          </button>
        </p>
      <p hidden={isHidden}>{feedback}</p>
      </div>
    </div>
  );
}

export default Transfer;
