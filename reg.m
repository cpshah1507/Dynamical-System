classdef reg < handle   
   % The following properties can be set only by class methods
   properties (SetAccess = public)
      region
   end
   methods
      function r = reg(region)
         r.region = region;
      end
      function unionresult = union(reg1,reg2)
         unionresult = [];
         
         i1 = 1; % Denotes index for region 1
         i2 = 1; % Denotes index for region 2
         epr = 1; % Denotes region where endPoint could be
         
         r1 = reshape(sort(reg1.region)',1,[]);
         r2 = reshape(sort(reg2.region)',1,[]);
         
         while (i1 <= length(r1)) || (i2 <= length(r2))
             if(i2>=length(r2))
                 while(i1<length(r1))
                     unionresult = [unionresult;r1(i1) r1(i1+1)];
                     i1=i1+2;
                 end
                 break;
             end
             
             if(i1>=length(r1))
                 while(i2<length(r2))
                     unionresult = [unionresult;r2(i2) r2(i2+1)];
                     i2=i2+2;
                 end
                 break;
             end
             
             if(r1(i1) <= r2(i2))
                 epr = 1;
                 sp = r1(i1); % sp denotes startPoint for an interval
                 i1 = i1+1;
                 ep = r1(i1); % ep denotes endPoint for an interval
             elseif(r2(i2) <= r1(i1))
                 epr = 2;
                 sp = r2(i2);
                 i2 = i2+1;
                 ep = r2(i2);
             end

             while (i1 ~= length(r1)) || (i2 ~= length(r2))
                 if(epr == 1)                
                    while (i2<=length(r2)) && (r2(i2)<=ep)
                        i2=i2+1;
                    end
                    if(mod(i2,2)==1)
                        i1=i1+1;
                        break;
                    else
                        ep = r2(i2);
                        epr = 2;
                    end
                 else
                     while (i1<=length(r1)) && (r1(i1)<=ep)
                         i1=i1+1;
                     end
                     if(mod(i1,2)==1)
                         i2=i2+1;
                         break;
                     else
                         ep = r1(i1);
                         epr = 1;
                     end
                 end
             end
             unionresult = [unionresult;sp ep];
         end  
      end % Union function
      function dif_result = difference(reg1,reg2)
         dif_result = [];
         
         i1 = 1; % Denotes index for region 1
         i2 = 1; % Denotes index for region 2
         
         r1 = reshape(sort(reg1.region)',1,[]);
         r2 = reshape(sort(reg2.region)',1,[]);
         
         while i1 <= length(r1)
             isp = r1(i1); % Interval Starting Point
             iep = r1(i1+1); % Interval Ending Point
             sp = isp; % Denotes starting Point of Interval to be Added in Result
             i2 = 1;
             flag = 0;
             while (i2 <= length(r2)) && (r2(i2)<isp)
                 i2=i2+1;
             end
             if((length(r2)==0) || (i2 == 1 && r2(i2)>iep) || (i2 == length(r2)+1))
                 dif_result = [dif_result; sp iep];
                 i1=i1+2;
                 continue;
             end
             while ((i2 <= length(r2) && isp <= r2(i2)) && (r2(i2) <= iep))
                 flag = 1;
                 if(mod(i2,2) == 1)
                     if(sp ~= r2(i2))
                        dif_result = [dif_result; sp r2(i2)];
                     end
                     if((isp <= r2(i2+1)) && (r2(i2+1) <= iep))
                         sp = r2(i2+1);
                         i2=i2+2;
                     else
                         sp = r2(i2+1);
                         break;
                     end
                 else
                     sp = r2(i2);
                     i2=i2+1;
                 end
             end
             if(sp < iep && flag==1)
                 dif_result = [dif_result; sp iep];
             end
             i1=i1+2;
         end
      end % Difference function
      function emptyResult = isRegEmpty(reg1)
          if(length(reg1.region) == 0)
              emptyResult = 1;
          else
              emptyResult = 0;
          end
      end % Empty Function
      function subsetResult = isSubset(reg1,reg2)
         i1 = 1; % Denotes index for region 1
         i2 = 1; % Denotes index for region 2
         
         r1 = reshape(sort(reg1.region)',1,[]);
         r2 = reshape(sort(reg2.region)',1,[]);
         
         sp = r2(i2);
         ep = r2(i2+1);
         
         while i2<=length(r2)
             i1 = 1;
             if((r1(i1)>sp) || r1(length(r1))<sp)
                 subsetResult = 0;
                 return
             end

             while i1<length(r1) && r1(i1+1)<=sp
                 i1=i1+1;
             end
             
             if(mod(i1,2)==0)
                 subsetResult = 0;
                 return
             else
                 if(r1(i1+1)>=ep)
                     i2=i2+2;
                     continue;
                 else
                     subsetResult = 0;
                     return
                 end
             end
         end
         subsetResult = 1;
      end % Subset Function
      function sumResult = sum(reg1,reg2)
         i1 = 1; % Denotes index for region 1
         i2 = 1; % Denotes index for region 2
         
         r1 = reshape(sort(reg1.region)',1,[]);
         r2 = reshape(sort(reg2.region)',1,[]);
         tempResult = reg([]);
         sumResult = reg([]);
         while i1<=length(r1)
             i2=1;
             while i2<=length(r2)
                temp = reg([r2(i2)+r1(i1) r2(i2+1)+r1(i1+1)]);
                tempResult.region = tempResult.union(temp);
                i2=i2+2;
             end
             sumResult.region = sumResult.union(tempResult);
             i1=i1+2;
         end
         sumResult = union(sumResult,tempResult);
      end % Sum Function
      function productResult = product(reg1,scalar)
         
         productResult = [];
         r1 = reshape(sort(reg1.region)',1,[]);
         if(scalar == 0)
             productResult = [0 0];
             return;
         end
         
         r1 = scalar * r1;
         i1 = 1;
         if(scalar < 0)
            while i1<length(r1)
                 if(r1(i1) > r1(i1+1))
                     temp = r1(i1);
                     r1(i1) = r1(i1+1);
                     r1(i1+1) = temp; 
                 end
                 i1=i1+2;
            end
         end
         i1 = 1;
         while i1<length(r1)
                productResult = [productResult;r1(i1) r1(i1+1)];
                i1=i1+2;
         end
      end % Product Function
      function squareResult = square(reg1)
          i1 = 1;
          r1 = reshape(sort(reg1.region)',1,[]);
          squareResult = reg([]);
          while i1<=length(r1)
              if(r1(i1) < 0 && r1(i1+1) >  0)
                 temp = reg([0 max(r1(i1),r1(i1+1))*max(r1(i1),r1(i1+1))]); 
              elseif(r1(i1) <0 && r1(i1+1) < 0)
                  temp = reg([r1(i1+1)*r1(i1+1) r1(i1)*r1(i1)]); 
              else
                  temp = reg([r1(i1)*r1(i1) r1(i1+1)*r1(i1+1)]); 
              end
              squareResult.region = squareResult.union(temp);
              i1=i1+2;
          end 
          squareResult = squareResult.region;
      end % Square Function
   end % methods
end % classdef