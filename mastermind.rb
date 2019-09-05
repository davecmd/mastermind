require 'sinatra'
require 'sinatra/reloader'

@@code = [];
@@choices;
@@output = [];

def generate_number
    value = rand(1..6);
    return value;
end

def generate_colour (value)
    case value
    when 1
        colour = 'red';
    when 2
        colour = 'green';
    when 3
        colour = 'blue';
    when 4
        colour = 'yellow';
    when 5
        colour = 'white';
    when 6
        colour = 'black';
    end
    return colour
end

def generate_code
    4.times {
        @@code.push(generate_colour(generate_number)); #push a random colour
    }
end

def check_code
  #  for a in 0..3 do
  #      @@output[a] = 'None';
  #  end 
    @@red_pegs = Array.new(4);
    @@white_pegs = Array.new(4);
    for i in 0..3 do
        if @@code[i] == @@choices[i]
            @@output.push('Red');
            @@red_pegs[i] = true;
        end
    end
        for s in 0..3 do
            for t in 0..3 do
                puts @@choices[s];
                puts @@code[t];
                #Bug: array will not match
                if  (@@red_pegs[s] != true && @@white_pegs[s] != true) && @@choices[s] == @@code[t] 
                    @@output.push('White');

                    @@white_pegs[t] = true;
                end
            end
        end
    
end

generate_code;

get '/' do
   puts 'STTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
    @@choices = [params['choice-one'],params['choice-two'],params['choice-three'],params['choice-four']];
        value = @@output;
    colour = @@choices;
    code = @@code;
    check_code;
    @@output = [];
    white_pegs = @@white_pegs;
    red_pegs = @@red_pegs;
    erb :index, :locals => {:value => value, :colour => colour , :code => code, :white_pegs => white_pegs, :red_pegs => red_pegs}
end