### A Pluto.jl notebook ###
# v0.11.12

using Markdown
using InteractiveUtils

# ╔═╡ 39549b96-f658-11ea-1bf7-8522f2850f35
function place_piece!(setup, piece, rem, isUnique)
# Does not test for invalid arguments 

# A trivial square is either empty, or in the case of placing
# an non-unique piece, contains another instance of that piece.

    col = 0
    ▫s = 0 # number of accounted trivial squares
    placed = false
    while !placed
        col += 1
        
        if setup[col] == ' '  ||  (!isUnique  &&  setup[col] == piece)
            ▫s += 1

            if ▫s == rem
                setup[col] = piece
                placed = true
            end                             

        end
        
    end
 
end

# ╔═╡ 78dee3a2-f658-11ea-3e16-45308f0b6783
function place_♜♚♜!(setup) 
# Does not test for invalid argument

    ♜L_placed = false
    ♚_placed  = false
    ♜R_placed = false

    col = 0

    while !♜R_placed
        col += 1

        if setup[col] == ' '
            if !♜L_placed
                setup[col] = '♜'
                ♜L_placed = true
            elseif !♚_placed
                setup[col] = '♚'
                ♚_placed = true
            else
                setup[col] = '♜'
                ♜R_placed = true
            end
        end
    end
end

# ╔═╡ 84178f44-f658-11ea-247d-9d796c005d9a
function chess960()
    setups = []
    

    for ♝dr in (1 : 2 : 7) # dark-squared bishop col
        for ♝lg in (2 : 2 : 8) # light-squared bishop col
            for ♛rem in (1 : 6) # of the remaining 6 empty (▫) cols
                for ♞remL in (1 : 4) # of the remaining 5 ♞-or-▫ cols
                    for ♞remR in (♞remL+1 : 5) # of the remaining 5 ♞-or-▫ cols
                        setup = [' '    for i in (1:8)]
                        setup[♝dr] = '♝'
                        setup[♝lg] = '♝'
                        
                         
                        place_piece!(setup, '♛', ♛rem, true)

                        place_piece!(setup, '♞', ♞remL, true)
                        place_piece!(setup, '♞', ♞remR, false)

                        place_♜♚♜!(setup)

                        # convert setup char array into a string ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅
                        setupStr = ""
                        for i in (1 : 8);    setupStr *= string(setup[i]);  end
                        # ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅

                        push!(setups, setupStr)
                    end
                end
            end
        end
    end


    setups
end

# ╔═╡ 8c2a7ce6-f658-11ea-3c8c-2b726af7e837
setups = chess960()

# ╔═╡ 20657616-f659-11ea-1a31-2d06b0175819
setups == unique(setups)

# ╔═╡ Cell order:
# ╠═39549b96-f658-11ea-1bf7-8522f2850f35
# ╠═78dee3a2-f658-11ea-3e16-45308f0b6783
# ╠═84178f44-f658-11ea-247d-9d796c005d9a
# ╠═8c2a7ce6-f658-11ea-3c8c-2b726af7e837
# ╠═20657616-f659-11ea-1a31-2d06b0175819
