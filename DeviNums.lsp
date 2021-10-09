(defun rnd (/)
  (if (not seed)
  
    (setq seed (getvar "DATE"))
  )
  (setq mod 65536; module
        mult 25173; multiplicator
        inc 13849; increment
        seed (rem (+ (* mult seed) inc) mod)
        random (/ seed mod)
  )
);defun rnd
(defun rndRange(/)
  (setq maxR 20; range
	movR 10; move
  )
  (- (fix(* maxR (rnd))) movR); generate digits beetween 0..max_r and move result on mov_r under 0
)
(defun C:DeviNums (/)
  (setq txtStyle (getvar "textstyle"))
  (setq numQ (getint "\nInput Rotation Angle for your TEXT (etc. 90): ")); send message to user to input angle
  (setq numH (getreal "\nInput Height for your TEXT: ")); send message to user to input text height
  (setq numC (getint "\nInput Color for your TEXT (etc. 1): ")); send message to user to input text color
  (if (= numQ nil) (setq numQ 0)); set default rotation angle
  (if (= numH nil) (setq numH 3)); set default text height
  (if (= numC nil) (setq numC 1)); set default text height
  (command "._STYLE" "Standard" "Bd" 0 1 0 "_N" "_N" "_N")
  (while (= (setq numSeq (rndRange)) 0)); repeat rndRange while numSeq == 0
  (setq txtInsert (getpoint "Select point to insert your text: "))
  (setq str (itoa numSeq)); set randomize result digit to string
  (while txtInsert ; repeat while user don't cancel selecting points use "ESC" key
    (if (> numSeq 0) (setq str (strcat "+" str))); checking if number < 0 then add "+" to string result
    (command "._TEXT" txtInsert numH numQ str); insert text in point with height = numH and rotation angle = numQ
    (command "_.chprop" "_last" "" "_color" numC ""); changing text color
    (setq txtInsert (getpoint "Select point to insert your text: "));waiting to input point from user
    (while (= (setq numSeq (rndRange)) 0)); repeat rndRange while numSeq == 0
    (setq str (itoa numSeq))
  );while txtInsert
  (setvar "textstyle" txtStyle)
  (princ)
);defun end

