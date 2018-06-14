clear();
// chdir C:\Users\... ; inserir endereço do projeto 
exec('bib_trabalho.sce');
exec('follow.sci');

scicv_Init();

disp('Lentilhas');


for i = 1:20
    obj = imread ('Lentilha_Melancia/lentilha_'+string(i)+'.png');
    im = obj(:,:);
    delete_Mat(obj);
    im = cinza(im);    

    a = 0;
    diam = 0;
    aux = zeros(size(im,1),size(im,2));  
    tipo = " ";  
    
    image = struct ('im', im, 'area', a, 'aux',aux, 'diam',diam, 'tipo',tipo);
   
    l(i) = Limiarizacao(image,240);
    
    l(i).tipo = 'lentilha'
    
    disp('lentilha_'+string(i)+'  Area: '+string(l(i).area)+' Diametro: '+string(l(i).diam)+' tipo: '+string(l(i).tipo));
   
end

disp('Melancias');

for i = 1:20
    obj = imread ('Lentilha_Melancia/melancia_'+string(i)+'.png');
    im = obj(:,:);
    delete_Mat(obj);
    im = cinza(im); 
    
    a = 0;
    diam = 0;
    aux = zeros(size(im,1),size(im,2)); 
    
    image = struct ('im', im, 'area', a, 'aux',aux, 'diam',diam, 'tipo',tipo);
       
    m(i) = Limiarizacao(image,240);    
    m(i).tipo = 'melancia'
   
    disp('melancia_'+string(i)+'  Area: '+string(m(i).area)+' Diametro: '+string(m(i).diam)+' tipo: '+string(m(i).tipo));
    
end

disp("Teste");

for i = 1:20
    obj = imread ('Lentilha_Melancia/teste/teste ('+string(i)+').png');
    im = obj(:,:);
    delete_Mat(obj);
        
    im = cinza(im);    

    a = 0;
    diam = 0;
    aux = zeros(size(im,1),size(im,2));  
    tipo = " ";  
    resultado = " ";
    
    image = struct ('im', im, 'area', a, 'aux',aux, 'diam',diam, 'tipo',tipo, 'resultado',resultado );
   
    t(i) = Limiarizacao(image,240);
   
    t(i).tipo = knn(t(i),l,m,3,i);
    t(i).resultado = verificacaoResultado(t(i), i)
    
   disp('teste_'+string(i)+'  Area: '+string(t(i).area)+' Diametro: '+string(t(i).diam)+' tipo: '+string(t(i).tipo)+' resultado: '+string(t(i).resultado));
   
end

Plotagem(t, m, l);

/*
for i = 1 : 20
    plot(t(i).area,t(i).diam,".");
    plot(m(i).area,m(i).diam,"r.");
    plot(l(i).area,l(i).diam,"g.");
end*/












