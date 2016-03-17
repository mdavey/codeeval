#lang racket

(define filename (if (= 1 (vector-length (current-command-line-arguments)))
             (vector-ref (current-command-line-arguments) 0)
             "data.txt"))

(define (remove-repeated-chars char chars)
  (if (and
       (> (length chars) 0)
       (eq? (car chars) char))
      chars
      (cons char chars)))

(define (remove-repetitions line)
 (list->string
  (foldr remove-repeated-chars '() (string->list line))))

(displayln
 (string-join
  (map remove-repetitions (file->lines filename))
  "\n"))
