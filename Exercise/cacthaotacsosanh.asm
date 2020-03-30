#bai 9: các thao tác so sánh
.data

.text
	li $s1, 10
	li $s2, 20
	
	seq $t1, $s1, $s2 #(s1 = s2) dung thi t1 = 1, sai t1 = 0, so sanh bang
	slt $t2, $s1, $s2 #(s1 < s2) dung thi t2 = 1, sai t2 = 0, so sanh nho hon
	sle $t3, $s1, $s2 #(s1 <= s2) dung thi t3 = 1, sai t3 = 0, so sanh nho hon hoac bang
	sgt $t4, $s1, $s2 #(s1 > s2) dung thi t4 = 1, sai t4 = 0, so sanh nho hon
	slt $t5, $s1, $s2 #(s1 >= s2) dung thi t5 = 1, sai t5 = 0, so sanh lon hon hoac bang