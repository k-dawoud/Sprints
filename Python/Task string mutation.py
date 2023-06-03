def function(string='abracadabra',position='5',character='k'):
    string = string[:5] + character + string[6:] # Write "abrac" then 'k' then "dabra" 
    print(string) # Print the new string
function() # Call function
