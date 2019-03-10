% psuedo code algorithm 1

L = alive points;
sigma = state;
U = geodesicDistanceFunction;

for p=1:size(img, 1)
    if p in seed 
        sigma = ALIVE;
        U_x = 0;
        L.append(p)
    else
        sigma = FAR_AWAY;
        U(p) = infinity;
        
end

while L ~= 0
    p = argmin(U(q))    % U(q) = min(U(x?1,y),U(x+1,y))
    sigma = COMPUTED
    update(R(i));       % eqation 5 update mean colour 
    for q in neighbourhood of p 
        Fc(p,R i ) = |Cp?Ci|    % equation 3 F
        compute local solution t(q) % equation 6
        if sigma(q) = alive and t(q)<U(q)
            U(q) = t(q);
        end
        if sigma(q) = FAR_AWAY
            sigma(q) = ALIVE;
            U(q) = t(q);
            add q to L 
        
        end
    end
end

        
    
