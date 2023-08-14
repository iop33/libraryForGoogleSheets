require "google_drive"

class Probna

  def initialize(ws)
    @mat=[]
    @kolona=[]
    @ws=ws
    @glr=-1
    @glk=-1
    @hederi=[]
    @genKolona=[]
    popuni()
  end

  def -(pr2)
    mat1 = @mat
    mat2 = pr2.mat
    h1 = []
    h2 = []
    h1.push(mat1[0])
    h2.push(mat2[0])
    
    if (h1!=h1)
      puts "Nisu isti hederi!"
      return nil
    end
    unija = mat1
    unija-=mat2[1..-1] 
    pov = Probna.new(@ws)
    pov.mat=unija
    return pov
  end

  def +(pr2)
    mat1 = @mat
    mat2 = pr2.mat
    h1 = []
    h2 = []
    h1.push(mat1[0])
    h2.push(mat2[0])
    
    if (h1!=h1)
      puts "Nisu isti hederi!"
      return nil
    end
    unija = mat1
    unija+=mat2[1..-1] 
    pov = Probna.new(@ws)
    pov.mat=unija
    return pov
  end


  def map(&b)
    mapnizpom = []
    f=0
    @genKolona.each do |x|
       if f==0
           f=1
       else
        m=x.to_i
        mapnizpom.push(m)
       end
    end
    mapniz = mapnizpom.map &b
    p mapniz
 end

 def select(&b)
    f=0
    mapnizpom = []
    @genKolona.each do |x|
      if f==0
        f=1
    else
     m=x.to_i
     mapnizpom.push(m)
    end
    end
    mapniz = mapnizpom.select &b
    p mapniz
 end

 def reduce(b)
    f=0
    mapnizpom = []
    @genKolona.each do |x|
      if f==0
        f=1
    else
     m=x.to_i
     mapnizpom.push(m)
    end
    end
    mapniz = mapnizpom.reduce(b)
    p mapniz
  end


  def sum()
    puts "uso u sum"
    s=0
    @genKolona.each do |g|
      
      if g.to_i != 0
        s=s+g.to_i
      end

    end
    puts s
    @genKolona.clear()
  end

  def avg()
    puts "uso u avg"
    su=0
    br=0
    @genKolona.each do |g|
      
      if g.to_i != 0
        su=su+g.to_i
        br+=1
      end

    end
    sredina= (su*1.0)/br
    puts sredina
    @genKolona.clear()
  end

  def vrednosti()

    c=self.class
    (1..(@genKolona.size-1)).each do |g|
      name=@genKolona[g]
      c.define_method("#{name}") do
        curbrr=0
        brr=0
        @genKolona.each do |d|
          if(d==name)
            curbrr=brr
          end
          brr+=1
        end
        
        brr=0
        puts curbrr
        @mat.each do |x|
          x.each do |y|
            if(brr==curbrr)
              puts y
            end
          end
          brr+=1
        end

      end

    end

  end


def generisanje(hederi)
  o=self.class
  
    hederi.each do |h|
      o.define_method("#{h}") do 
        perpok=-1
        @genKolona.clear()
        @mat.each do |x|
          currpok=0
          x.each do |y|
           if(y==h)
            perpok=currpok
          end
          if(currpok==perpok)
            @genKolona.push(y) 
          end
          currpok+=1
        end
       end
       vrednosti()
       return self
      end
    end
end

  def popuni()
    flag=0
    @glr=-1
    @glk=-1
    ddr=@ws.num_rows
    ddk=@ws.num_cols

    (1..@ws.num_rows).each do |row|
      (1..@ws.num_cols).each do |col|
        if(flag==0 && @ws[row,col]!="")
          @glr=row
          @glk=col
          flag=1
        end
      end
    
    end
    izbacivanje = []
  (1..@ws.num_rows).each do |row|
    (1..@ws.num_cols).each do |col|
      if (@ws[row,col]!="")
        if (@ws[row,col].include? "total")
          izbacivanje.push(row)
        end
        if (@ws[row,col].include? "subtotal")
          izbacivanje.push(row)
        end
      end
    end
  end

  (1..@ws.num_rows).each do |row|
    fl=0
    pom=[]
      (1..@ws.num_cols).each do |col|
        if(row>=@glr && col>=@glk && row<=ddr && col<=ddk && !(izbacivanje.include? row))
          if(row==@glr)
            @hederi.push(@ws[row,col])
          end
          pom.push(@ws[row,col])
          fl=1
        end
      end
      if(fl==1)
        @mat.push(pom)
      end
    end
    generisanje(@hederi)
    
end

  def row(br)
    st=0
    @povrow=[]
    @mat.each do |x|
      x.each do |y|
          if(br==st)
           @povrow.push(y)
          end
      end
      st+=1
    end
    return @povrow
  end

  def print()
    @mat.each do |x|
      x.each do |y|
            puts y
      end
    end
  end

  def [](kolona) 
   
  if kolona.is_a? String
    @kolona.clear()
    pokkol=0
    @povkol=[]
    @mat.each do |x|
      kol=0
      x.each do |y|
          if(kolona==y)
            pokkol=kol
          end
          kol+=1
      end
    end

    @mat.each do |x|
      kol=0
      x.each do |y|
          if(kol==pokkol)
            @povkol.push(y)
          end
          kol+=1
      end
    end
    @kolona=@povkol
    return self
  end
  vr=@kolona[kolona]
  @kolona.clear
  @kolona.push(vr)
  return self
  
end  

def []=(kolona,nvr)
  
  br=0
  r=-1
  k=-1
  (1..@ws.num_rows).each do |row|
    (1..@ws.num_cols).each do |col|
      if(@ws[row,col]==@kolona[0])
        k=col
        
      end
      if(br==kolona && k==col)
        r=row
      end
    end
    if(k!=-1)
      br+=1
    end
  end
  
   @ws[r,k]=nvr
   @mat[r-@glr][k-@glk]=nvr
   @ws.save
   @ws.reload
   

end
  attr_accessor :mat
  attr_reader :mat
  def to_s
    
    "#@kolona"
  end

end

