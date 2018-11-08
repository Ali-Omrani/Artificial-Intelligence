import math
import copy
import heapq
iteration = 0
def total_remaining(problem_size, board_state):
    running = 0
    domains = calc_domain(problem_size, board_state)
    for i in xrange(problem_size):
        for j in xrange(problem_size):
            if board_state[i][j]:
                continue
            running += len(domains[i][j])
    return running , domains

def DFS(problem_size , initial_state):
    if not input_valid_test(problem_size , initial_state):
#        print "Wrong initial_state!"
        return None
    elif goal_test(problem_size, initial_state):
#        print "Behtarin initial_state!"
        return initial_state

    # print("start")
    heap = []
    # debug
    # print(heap)
    h, domains = total_remaining(problem_size, initial_state)
    c = 0

    heapq.heappush(heap, [h+c, c, domains, initial_state]) 
    # print("append done", heap)
#    heap_size =1;
    while heap:
        temp_list = heapq.heappop(heap)
        # print "-----------------------------------------------"
        # print temp_list
        # print "-----------------------------------------------"
        f = temp_list[0]
        c = temp_list[1]
#        print "chose f = " , f , "    c = ", c
        domains = temp_list[2]
        curr_state = temp_list[3]
#        print "-----------------------------------------------"
#        for line in curr_state:
#            print line
#        print "-----------------------------------------------"
        # print("pop",curr_state)
        if goal_test(problem_size, curr_state):
            print "Khodam hallesh kardam :)"
            return curr_state

        # print("wasnt goal")
        # print "thats result ----------------------------------------------"
        result = expand(problem_size, c, domains, curr_state)
        # print "thats result ------------------------------------------done"
        for x in result:
            # print "x" , x
            if not x in heap:
                heapq.heappush(heap, x)
#                heap_size+=1
#        print "heap_size = " , heap_size

    print "Hal nashod :("
    return None


def expand(problem_size, c, domains, board_state):
    global iteration
    iteration +=1
#    print "iteration = " , iteration
#    print "expand: Begining!"
    # row,col = MRV_choose(problem_size, board_state)
    row,col = first_empty(problem_size, board_state)
    # domain = calc_single_domain(problem_size, board_state, row, col)
    # -----------------------------------------------------------------
    result = []
    # for row in xrange(problem_size):
    #     for col in xrange(problem_size):
    #         if board_state[row][col]:
    #             continue
    #         else:
    #             for value in domains[row][col]:
    #                 new_state = copy.deepcopy(board_state)
    #                 new_state[row][col] = value
    #                 h , new_domain = total_remaining(problem_size, new_state)
    #                 temp = [h+c+1, c+1, new_domain, new_state]
    #                 result.append(temp)
    # return result
    # -----------------------------------------------------------------
    # result = []
    # for value in domain:
    #     new_state[row][col] = value
    #     # print "new_state",new_state 
    #     result.append(new_state)
    #     # print "result",result

    for value in domains[row][col]:
        new_state = copy.deepcopy(board_state)
        new_state[row][col] = value
        h , new_domain = total_remaining(problem_size, new_state)
#        print "h =", h , "     c = " , c
        temp = [h+c+1, c+1, new_domain, new_state]
        result.append(temp)
#    print "==================================="
    return result

def MRV_choose(problem_size, board_state):
    domains = calc_domain(problem_size, board_state)
    min_domain_size = problem_size+1
    min_row = -1
    min_col = -1
    for i in xrange(problem_size):
        for j in xrange(problem_size):
            if domains[i][j] == [-1]:
                continue

            if len(domains[i][j]) < min_domain_size:
                min_domain_size = domains[i][j]
                min_col = j
                min_row = i
            if len(domains[i][j]) <= math.sqrt(problem_size):
                return min_row, min_col


    return min_row, min_col

def parser(filepath):
    f = open(filepath)
    line = f.readline()
    f.close()
    size = line.split(" ")[0]
    size = int(size)
    print "size = " , size 
    items = line.split(",")
    items[0] = items[0].split("[")[1]
    items[-1] = items[-1].split("]")[0]
    items = map(int, items)
    board = []
#    print "-----------------------------------------------"
    for row in xrange(size):
        boardline = items[row*size:row*size+size]
        board.append(boardline)
#        print boardline
#    print "-----------------------------------------------"
    print "board =" , board
    return size , board

def input_valid_test(problem_size , initial_state):
    # checking row by row
    
    for row in xrange(problem_size):
        a = [True for x in xrange(problem_size)]
        for col in xrange(problem_size):
            if initial_state[row][col] == 0:
                continue
            if a[initial_state[row][col]-1]:
                a[initial_state[row][col]-1] = False
            else:
                return False


    print "after row check"
    # checking col by col

    
    for col in xrange(problem_size):
        a = [True for x in xrange(problem_size)]
        for row in xrange(problem_size):
            if initial_state[row][col] == 0:
                continue
            if a[initial_state[row][col]-1]:
                a[initial_state[row][col]-1] = False
            else:
                return False

    print "after col check"
    # checking block by block

    
    block_size = int(math.sqrt(problem_size))
    for i in xrange(block_size):
        for j in xrange(block_size):
            # we n^2 block, here i have selected block[i][j] for checking
            a = [True for x in xrange(problem_size)]
            for row in xrange(block_size):
                for col in xrange(block_size):
                    temp = initial_state[i*block_size + row][j*block_size +col]
                    if temp == 0:
                        continue
                    if a[temp-1] :
                        a[temp-1] = False
                    else:
                        return False

    print "after block check"
    return True 

def calc_single_domain(problem_size, board_state, row, col):
    d1 = row_domain(problem_size, board_state, row)
    # print(d1 , "that was row_domain")
    d2 = col_domain(problem_size, board_state, col)
    # print(d2 , "that was col_domain")
    d3 = block_domain(problem_size, board_state, row, col)
    # print(d3 , "that was block_domain")
    domain = unify_domains(d1 , d2 , d3)
    return domain

def calc_domain(problem_size, board_state):
    
    row_domains = []
    for row in xrange(problem_size):
        row_domains.append(row_domain(problem_size, board_state, row))
    
    col_domains = []
    for col in xrange(problem_size):
        col_domains.append(col_domain(problem_size, board_state, col))

    block_domains = []
    block_size = int(math.sqrt(problem_size))
    for i in xrange(block_size):
        block_domain_line = []
        for j in xrange(block_size):
            block_domain_line.append(block_domain(problem_size, board_state, block_size*i, block_size*j))
        block_domains.append(block_domain_line)
    
    domains = []
    # print "---------------------calc_domain--------------------"
    for i in xrange(problem_size):
        domain_line = []
        for j in xrange(problem_size):
            if board_state[i][j]:
                 domain_line.append([-1])
                 continue
            
            domain = unify_domains(row_domains[i], col_domains[j], block_domains[i/block_size][j/block_size])
            domain_line.append(domain)
        # print domain_line 
        domains.append(domain_line)
    # print "----------------------------------------------------"
    return domains

def goal_test(problem_size, board_state):
    available = [problem_size for i in xrange(problem_size)]
    # print available
    for i in xrange(problem_size):
        for j in xrange(problem_size):
            if board_state[i][j] != 0:
                available[board_state[i][j]-1] -= 1

    # print(available)
    for i in xrange(problem_size):
        if available[i] != 0:
            return False
    return True

def first_empty (problem_size, board_state):
    for row in xrange(problem_size):
        for col in xrange(problem_size):
            if board_state[row][col] == 0:
                return row,col

def row_domain(problem_size, board_state, row):
    complete_domain = range(1, problem_size+1)
    used = [x for x in board_state[row] if x!= 0]
    domain = [x for x in complete_domain if x not in used]
    return domain

def col_domain(problem_size, board_state, col):
    complete_domain = range(1, problem_size+1)
    used = []
    for row in xrange(problem_size):
        if board_state[row][col] != 0:
            used.append(board_state[row][col])
    domain = [x for x in complete_domain if x not in used]
    return domain

def block_domain(problem_size,board_state, row , col):
    complete_domain = range(1, problem_size+1)
    used = []
    block_size = int(math.sqrt(problem_size))
    row = int(row/block_size)*block_size
    col = int(col/block_size)*block_size

    for i in xrange(block_size):
        for j in xrange(block_size):
            used.append(board_state[i+row][j+col])

    domain = [x for x in complete_domain if x not in used]
    return domain

def unify_domains (d1 , d2 ,d3):
    temp = [x for x in d1 if x in d2]
    domain = [x for x in temp if x in d3]
    return domain

# def init_domain(problem_size, initial_state):
#     result = []
#     for i in xrange(problem_size):
#         domain_line = []
#         for j in xrange(problem_size):
            
#             if initial_state[i][j]:
#                 domain_line.append([-1])
#                 continue

#             domain = calc_domain(problem_size, initial_state, i, j)
#             domain_line.append(domain)
#         print domain_line
#         result.append(domain_line)
#     return result

if __name__ == "__main__":
    print ""
    # filepath = raw_input()
#    filepath = "sample_test.txt"
    filepath = "t9.txt"
    problem_size , initial_state = parser(filepath)
    # initial_domains = init_domain(problem_size, initial_state)

        
    res = DFS(problem_size, initial_state)
#    print "---------------------------------------------"
#    for line in res:
#        print line
#    print "---------------------------------------------"
