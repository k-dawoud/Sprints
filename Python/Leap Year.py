print("Enter Year: ")
year =  input()

def is_leap(year): 
    if( (year %4 ==0) and (year %100 !=0) or (year %400 ==0) ):
        print("This year is a leap year.")
    else:
        print("This year isn't a leap year.") 

is_leap(int(year))
