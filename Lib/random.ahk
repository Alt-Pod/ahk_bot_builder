random_bool(odds) {
	Random, percentage, 0, 100
	treshold := 100 - odds * 100
	if(percentage > treshold) {
		return true
	}
	return false
}

random_guid() {
   format = %A_FormatInteger%       ; save original integer format 
   SetFormat Integer, Hex           ; for converting bytes to hex 
   VarSetCapacity(A,16) 
   DllCall("rpcrt4\UuidCreate","Str",A) 
   Address := &A 
   Loop 16 
   { 
      x := 256 + *Address           ; get byte in hex, set 17th bit 
      StringTrimLeft x, x, 3        ; remove 0x1 
      h = %x%%h%                    ; in memory: LS byte first 
      Address++ 
   } 
   SetFormat Integer, %format%      ; restore original format 
   h := SubStr(h,1,8) . "-" . SubStr(h,9,4) . "-" . SubStr(h,13,4) . "-" . SubStr(h,17,4) . "-" . SubStr(h,21,12)
   return h
}