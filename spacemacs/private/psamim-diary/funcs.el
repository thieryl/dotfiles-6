(require 'parse-time)

(setq
 psamim-diary-diary-directory "/home/samim/Notes/daily/"
 psamim-diary-diary-template "/home/samim/Notes/archive/template.org"
 psamim-diary-diary-template-in-a-while "/home/samim/Notes/archive/template-in-a-while.org"
 psamim-diary-in-a-while "5" ;; Fridays
 psamim-diary-date-format "%Y-%m-%d")

(defun psamim-diary-open-today ()
  (interactive)
  (let
      ((file-name (concat
                   psamim-diary-diary-directory
                   (format-time-string psamim-diary-date-format)
                   ".org"))
       (template (if (string= (format-time-string "%w") psamim-diary-in-a-while)
                     psamim-diary-diary-template-in-a-while
                   psamim-diary-diary-template)))

    (if (file-exists-p file-name)
        (find-file file-name)
      (progn
        (copy-file template file-name)
        (find-file file-name)
        (beginning-of-buffer)
        (insert (concat
                 (format-time-string "%A") "\n"
                 (format-time-string "%B %e, %Y") "\n"
                 (calendar-persian-date-string) "\n"
                 (calendar-bahai-date-string) "\n\n"))))
    (end-of-buffer)))

(defun psamim-diary-next-day-string (current-day diff-day)
  (format-time-string psamim-diary-date-format
     (time-add
      (apply (function encode-time)
             `(0 0 0
                 ,(nth-value 3 (parse-time-string current-day))
                 ,(nth-value 4 (parse-time-string current-day))
                 ,(nth-value 5 (parse-time-string current-day))
                 0 t 0))
      (days-to-time diff-day))))

(defun psamim-diary-year-string (current-day)
  (format-time-string  "%m-%d"
                       (apply (function encode-time)
                              `(0 0 0
                                  ,(nth-value 3 (parse-time-string current-day))
                                  ,(nth-value 4 (parse-time-string current-day))
                                  ,(nth-value 5 (parse-time-string current-day))
                                  0 t 0))))

(defun psamim-diary-next-file (file-name diff)
  (concat
   psamim-diary-diary-directory
   (psamim-diary-next-day-string (file-name-base file-name) diff)
   ".org"))

(defun psamim-diary-open (file)
   (interactive)
   (if (file-exists-p file)
       (let ((prev-buffer (current-buffer)))
         (find-file file)
         (kill-buffer prev-buffer))
     (message "Not found")))

(defun psamim-diary-show-next ()
  (interactive)
  (let ((count 1)
        (next-file (psamim-diary-next-file (buffer-file-name) 1)))
  (while (and (< count 1000) (not (file-exists-p next-file)))
    (setq count (1+ count))
    (setq next-file (psamim-diary-next-file (buffer-file-name) count)))
  (psamim-diary-open next-file)))

(defun psamim-diary-show-prev ()
  (interactive)
  (let ((count -1)
        (next-file (psamim-diary-next-file (buffer-file-name) -1)))
    (while (and (> count -1000) (not (file-exists-p next-file)))
      (setq count (1- count))
      (setq next-file (psamim-diary-next-file (buffer-file-name) count)))
    (psamim-diary-open next-file)))

(defun psamim-diary-show-prev-year ()
  (interactive)
  (let ((count -1)
        (next-file (psamim-diary-next-file (buffer-file-name) -365)))
    (while (and (> count -1000) (not (file-exists-p next-file)))
      (setq count (- count 365))
      (setq next-file (psamim-diary-next-file (buffer-file-name) count)))
    (psamim-diary-open next-file)))

(defun psamim-diary-dired-day ()
  (interactive)
  (split-window nil 10 'above)
  (find-dired psamim-diary-diary-directory
              (concat
               "-name '*"
               (psamim-diary-year-string (file-name-base buffer-file-name))
               "*'")))
