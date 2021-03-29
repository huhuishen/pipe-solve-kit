;;; �ܹ�������KEYӦ��Ψһȷ��һ�������������ⲿ�������ݿ�õ��ò����ĳߴ���Ϣ������ͳ����Ϣ
;;; ������KEY ͨ��ģ��ʵ���Զ����� ����ʱʹ�õ������ɲ�������·���ṩ


(defun psk-comp-getbom (comp)
  (cond
    ((= "PATH" (psk-comp-getname comp))
     (list
       "���"
       (cons "DN" (psk-path-getportsize comp))
       (cons "LEN" (psk-path-getlength comp))
     )
    )
    ((= "FIT" (psk-comp-getname comp))
     (setq tp (psk-comp-gettype comp))
     (cond ((= "ELBOW" tp)
	    (setq p	(p-dxf en 10)
		  ports	(psk-comp-getports comp)
		  pts	(mapcar 'psk-port-getangle ports)
		  d	(psk-path-getportsize comp)
		  ;;TODO
		  r	(* (p-get comp "ERF") d)
			;;TODO
	    )
	    (psk-draw-elbow p (car pts) (cadr pts) d r)
	   )
	   ((= "REDUCER" tp)
	    (setq p	(p-dxf en 10)
		  ports	(psk-comp-getports comp)
	    )
	    (psk-draw-reducer
	      (psk-port-getpos (car ports))
	      (psk-port-getpos (last ports))
	      (psk-port-getangle (last ports))
	      (psk-port-getsize (car ports))
	      (psk-port-getsize (last ports))
	    )
	   )
	   ((= "TEE" tp)
	    (setq p	(p-dxf en 10)
		  ports	(psk-comp-getports comp)
	    )
	    (psk-draw-tee
	      (psk-port-getpos (car ports))
	      (psk-port-getpos (cadr ports))
	      (psk-port-getpos (last ports))
	      (psk-port-getangle (car ports))
	      (psk-port-getangle (cadr ports))
	      (psk-port-getangle (last ports))
	      (psk-port-getsize (car ports))
	      (psk-port-getsize (cadr ports))
	      (psk-port-getsize (last ports))
	      (p-get comp "ERF")
	    )
	   )
	   ((= "TEE-S" tp)
	    (setq p	(p-dxf en 10)
		  ports	(psk-comp-getports comp)
	    )
	    (psk-draw-tee-s
	      (psk-port-getpos (car ports))
	      (psk-port-getpos (cadr ports))
	      (psk-port-getpos (last ports))
	      (psk-port-getangle (car ports))
	      (psk-port-getangle (cadr ports))
	      (psk-port-getangle (last ports))
	      (psk-port-getsize (car ports))
	      (psk-port-getsize (cadr ports))
	      (psk-port-getsize (last ports))
	      (p-get comp "ERF")
	      (p-get comp "AL")
	    )
	   )
	   ((= "BRANCH" tp)
	    (setq p	(p-dxf en 10)
		  ports	(psk-comp-getports comp)
	    )
	    (psk-draw-branch
	      (psk-port-getpos (cadr ports))
	      (psk-port-getangle (car ports))
	      (psk-port-getangle (cadr ports))
	      (psk-port-getsize (car ports))
	      (psk-port-getsize (cadr ports))
	      (p-get comp "ERF")
	    )
	   )
	   ((= "CROSS" tp)
	    (setq p	(p-dxf en 10)
		  ports	(psk-comp-getports comp)
	    )
	    (psk-draw-cross
	      (psk-port-getpos (car ports))
	      (psk-port-getpos (cadr ports))
	      (psk-port-getpos (caddr ports))
	      (psk-port-getpos (last ports))
	      (psk-port-getangle (car ports))
	      (psk-port-getangle (cadr ports))
	      (psk-port-getangle (caddr ports))
	      (psk-port-getangle (last ports))
	      (psk-port-getsize (car ports))
	      (psk-port-getsize (cadr ports))
	      (psk-port-getsize (caddr ports))
	      (psk-port-getsize (last ports))
	      (p-get comp "ERF")

	    )
	   )
     )
    )
  )
)
(defun psk-comps-getbom	(comps / r)
  (foreach comp	comps
    (setq r (cons (psk-comp-getbom comp) r))
  )
  r
)