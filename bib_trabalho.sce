function s = cinza(im)
    s = im(:,:,1)/3+im(:,:,2)/3+im(:,:,3)/3
endfunction

function s = Limiarizacao(image,T)
    
    image.im = double(image.im);
       
    for i = 1:size(image.im,1)
        //disp([i]);
        for j = 1:size(image.im,2)
            
            if image.im(i,j) < T then
               image.aux(i,j) = 1;
               image.area = image.area + 1;
            else
                image.aux(i,j) = 0;
            end
                        
        end        
    end
    
    //matplot(image.aux);
    image = Diametro(image);

    //matplot(image.aux);
    s = image;
    
endfunction
    
    
function s = Diametro(image)
    [x y] = follow(image.aux);
    maior = 0;
    distancia = 0;
    for i=1:(size(x,1)-1)
        
        for j=i+1:size(y,1)
            distancia = sqrt(((x(i)-x(j))**2)+((y(i)-y(j))**2));
            if distancia > maior
                maior = distancia;
            end
        end
    end
    image.diam = maior;
//    disp(image.diam);
    s =  image;
        
            
endfunction


function s = knn(teste,melancias,lentilhas,k,i)
    vizinhos = cat(1,melancias,lentilhas);
    //disp(size(vizinhos));
    distanciaVizinhos = zeros(1,size(vizinhos,1));
     
    //disp(size(vizinhos,1));
    for i = 1:size(vizinhos,1)
        distanciaVizinhos(i) = distanciaEuclidiana(teste.area,vizinhos(i).area,teste.diam,vizinhos(i).diam); 
    end 
    
   // disp(distanciaVizinhos);   
    
    [v indice] = gsort(distanciaVizinhos,'g','i') ;
    
    /*for i = 1:size(vizinhos,1)
         disp(string(indice(i))+':'+string(v(i)));
    end*/
   
    
    kmelancia = 0;
    klentilha = 0;
    
    for i = 1 : k
      //  disp(indice(i));
        //disp(vizinhos(indice(i)).tipo)
        if(strcmp(vizinhos(indice(i)).tipo,'melancia','i') == 0)
             kmelancia = kmelancia + 1;          
        else
            klentilha = klentilha+1;
        end
    end
    
   // disp('kmelancia: '+string(kmelancia)+' klentilha: '+string(klentilha));
    
    if (kmelancia > klentilha)
            tipo = 'melancia';
    else
            tipo = 'lentilha';       
    end
    
    s = tipo;
    
endfunction

function s= distanciaEuclidiana(x1,x2,y1,y2)
    s = sqrt((x2-x1)^2+(y2-y1)^2); 
endfunction

function s = verificacaoResultado(teste, i)
    if (strcmp(teste.tipo,'melancia','i') == 0)
            if( i > 10 )
                s = '+';
            else
                s = '-';
            end
    else
            tipo = 'lentilha';
            if( i < 11 )
                s = '+';
            else
                s = '-'; 
            end       
    end
endfunction

function s = Plotagem(t, m, l)

plot(1100,55,"r."); //melancia treino
plot(1100,55,"g."); // lentilha treino
plot(1100,55,"*"); //melancia teste +
plot(1100,55,"black*"); //melancia teste -
plot(1100,55,"^"); // lentilha teste +
plot(1100,55,"black^"); // lentilha teste -

acertos = 0;
acuracia = 0;

 for i = 1:20       
    plot(m(i).area,m(i).diam,"r.");
    plot(l(i).area,l(i).diam,"g.");
    
    if(strcmp(t(i).tipo,'melancia','i') == 0)
        if (strcmp(t(i).resultado,'+','i') == 0)
             acertos = acertos + 1;
             plot(t(i).area,t(i).diam,"*");
        else
            plot(t(i).area,t(i).diam,"black*");
        end
    else
        if (strcmp(t(i).resultado,'+','i') == 0)
             acertos = acertos + 1;
             plot(t(i).area,t(i).diam,"^");
        else
            plot(t(i).area,t(i).diam,"black^");
        end
    end
  end
  
  acuracia = acertos/size(t);
  xtitle("K-means aplicado na classificação de sementes de lentilha e melancia.");
  xlabel("Área");
  ylabel("Diametro");
  legend('Melancia treino','Lentilha treino','Melancia teste +','Melancia teste -','Lentinha teste +', 'Lentilha teste -',2);

  disp('acurácia: '+string(acuracia(1)));
  s = 0;
endfunction





