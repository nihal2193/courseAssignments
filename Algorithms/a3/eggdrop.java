import java.util.*;

class eggdrop
{
	public static void main(String arg[])
	{
		Scanner sc = new Scanner(System.in);
		String inputLine = sc.nextLine();
		int floors = Integer.parseInt(inputLine.replaceAll(",.*",""));
		int eggs = Integer.parseInt(inputLine.replaceAll(".*,",""));
		int base = 0;
		// LinkedList<Integer> L = new LinkedList<Integer>();
		// L.addLast(2);
		// L.addLast(9);
		// L.set(1,3);
		// L.addAll(L);
		// System.out.println(L);
		LinkedList<Integer> a = minTrails(base,floors,eggs);
		System.out.println(a.size());
		for(int i=0;i<a.size();i++)
		{
			
			if(i == a.size()-1)
			{
				System.out.print(a.get(i));		
			}
			else
			{
				System.out.print(a.get(i)+",");
			}
		}

		


	}

	public static LinkedList minTrails(int base, int floors, int eggs)
	{
		// System.out.println("base "+base+" floors "+floors+" eggs "+eggs);
		LinkedList<Integer> ans = new LinkedList<Integer>();
		if(base <0 || floors <=0 || eggs < 1)
		{
			return ans;
		}

		int[][] W = new int[floors+1][eggs+1];
		int[][] Floors = new int[floors+1][eggs+1];

		
		//0 floors and k eggs
		for(int i=0;i<eggs+1;i++)
		{
			W[0][i] = 0;
		}

		//1 egg and n floors

		for(int i=0; i<floors+1;i++)
		{
			if(eggs > 1)
			{		
				W[i][1] = i;
				Floors[i][1] = i;	
			}

			if(eggs == 1)
			{
				W[i][1] = i-1;
				Floors[i][1] = i-1;
				ans.addLast(Floors[i][1]);
				if(i == floors)
				{
					for(int k = 0;k<ans.size();k++)
					{
						ans.set(i,base + ans.get(i));
					}
					return ans;
				}
			}
		}

		//1 floor and n eggs
		if(floors == 1)
		{
			ans.addLast(base+floors);
			return ans;
		}

		int steps = 0;
		if(eggs == 2)
		{
			steps = (int)Math.ceil((Math.sqrt(1+8*floors)-1)/2);
			int remaining_steps = steps;
			while(steps<floors)
			{
				remaining_steps = remaining_steps - 1;
				ans.addLast(steps);
				steps+=remaining_steps;
			}

			int last = ans.getLast();
			int before_last = ans.get(ans.size()-2>=0?ans.size()-2:base);
			
			for(int i = before_last+1 ; i <last;i++ )
			{
				ans.addLast(i);
			}

			for(int k = 0;k<ans.size();k++)
			{
				ans.set(k,base + ans.get(k));
			}
			return ans;
		}


		

		//i floors and j eggs
		for(int j = 2; j<=eggs ; j++)
		{
			for(int i = 1; i<=floors; i++)
			{		
				W[i][j] = Integer.MAX_VALUE;
				for(int k = 1; k <= i; k++)
				{
					int res = 1+ Math.max(W[i-k][j],W[k-1][j-1]);
					if(res <= W[i][j])
					{
						W[i][j] = res;
						Floors[i][j] = k ;
					}
				}
				
			}
		}

		// System.out.println("steps "+W[floors][eggs]);

		for(int j=0;j<=eggs;j++)
		{
			for(int i=0;i<=floors;i++)
			{
			
				// if(Floors[i][j]>0)
					// System.out.print(W[i][j]+" ");
			}
			// System.out.println();
		}


		for(int j=0;j<=eggs;j++)
		{
			for(int i=0;i<=floors;i++)
			{
			
				// if(Floors[i][j]>0)
					// System.out.print(Floors[i][j]+" ");
			}
			// System.out.println();
		}
		// LinkedList L1 = new LinkedList();
		// LinkedList L2 = new LinkedList();

		
		// L1 = minTrails(Floors[floors][eggs]-1,eggs-1);
		// L.addLast();
		// L2 = minTrails();

		
		int critic = Floors[floors][eggs];
		LinkedList<Integer> right = minTrails(Floors[floors][eggs],floors-Floors[floors][eggs],eggs);
		// System.out.println("critic "+critic+" "+right);
		LinkedList<Integer> left = minTrails(base,Floors[floors][eggs]-base-1,eggs-1);
		// System.out.println("critic "+critic+" "+left);

		right.addFirst(critic);
		left.addFirst(critic);	
		return right.size()>left.size()?right:left;
	}



}