import java.util.*;
class tile
{
	public static void main(String arg[])
	{
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		LinkedList<Integer> left = new LinkedList<Integer>();
		LinkedList<Integer> right = new LinkedList<Integer>();
		int emptyCount = 0;
		int max = n*n+1;  //serves as t
		int min = -1; // serves as s

		boolean[] included = new boolean[n*n];

		//System.out.println(" source and dest vertices "+min + "  "+max);

		for( int i=0; i<n; i++)
		{
			for(int j=0; j<n; j++)
			{	
				int isEmpty = sc.nextInt();
				if( isEmpty == 1)
				{
					emptyCount++;
					if((i*n+j+1+i)%2 != 0)
						left.addLast(i*n+j+1);
					else
						right.addLast(i*n+j+1);


				}
				included[i*n+j] = false;
			}			
		}

		if(emptyCount%2==1 || n*n % 2 == 1 || left.size() != right.size())
		{
			System.out.println(0);
		}
		else
		{
			//System.out.println(1);
			//System.out.println("emptyCount "+emptyCount);
			int[] L = new int[emptyCount/2];
			int[] R = new int[emptyCount/2];

			for(int i=0; i<emptyCount/2; i++)
			{
				L[i] = left.get(i);
				R[i] = right.get(i);
			}

			LinkedList[] edges = new LinkedList[emptyCount+1];
			for(int i=0; i<emptyCount/2; i++)
			{
				edges[i] = new LinkedList<Integer>();
				if(isPresent(right,L[i]-n))
					edges[i].addLast(L[i]-n);

				if(isPresent(right, L[i]-1))
					edges[i].addLast(L[i]-1);

				if(isPresent(right, L[i]+1))
					edges[i].addLast(L[i]+1);

				if(isPresent(right, L[i]+n))
					edges[i].addLast(L[i]+n);


				//System.out.println(L[i] + " edges "+edges[i]);

			}

			for(int i = emptyCount/2; i<emptyCount; i++)
			{
				edges[i] = new LinkedList<Integer>();
				edges[i].addLast(max);
				//System.out.println(R[i - emptyCount/2]+" destination "+edges[i]);
			}

			edges[emptyCount] = new LinkedList<Integer>();
			for(int i = 0; i<emptyCount/2; i++)
			{
				edges[emptyCount].addLast(left.get(i));
			}

			LinkedList mm = new LinkedList();
			mm.addLast(3);
			mm.clear();
			//System.out.println(" source "+edges[emptyCount]);
			//System.out.println("left "+left);	
			//System.out.println("right "+right);
			//System.out.println(" list is null "+mm.size()+" "+mm);	

			int c =0;


			while(edges[emptyCount].size() > 0 && c<15)
			{
				LinkedList[] copyEdges = edges;
				for(int i=0; i<emptyCount;i++)
				{
					//System.out.println((i<emptyCount/2?L[i]:R[i - emptyCount/2])+"  "+copyEdges[i]);
					included[i] = true;
				}

				int v = (int)copyEdges[emptyCount].get(0);
				Stack s = new Stack();
				s.push(v);
				//System.out.println(s+" out of while vertex "+v);
				int id = isPresent(left, v)?left.indexOf(v):emptyCount/2+right.indexOf(v);
				int ii=0;

				
				if(copyEdges[id].size() == 0)
				{						
					System.out.println(0);
					return;
				}				

				while(!isPresent(copyEdges[id], max) && copyEdges[id].size()>0 )
				{

					
					v = (int)copyEdges[id].get(0);

					//prevent cycles
					for(int i=0;i<emptyCount;i++)
					{
						if(copyEdges[i].contains(v))
							copyEdges[i].remove(copyEdges[i].indexOf(v));
					}

					s.push(v);
					id = isPresent(left, v)?left.indexOf(v):emptyCount/2+right.indexOf(v);
					//System.out.println(s+" vertex "+v);
					
					if(copyEdges[id].size() ==0)
					{
						int fromUnique = (int)s.pop();

						int unique = (int)s.pop();
						int toUnique = (int)s.peek();
						int toRemove = isPresent(left, toUnique)?left.indexOf(toUnique):emptyCount/2+right.indexOf(toUnique);
						//System.out.println("toUnique "+toUnique+" index "+toRemove+" copyEdges "+copyEdges[toRemove]+" toRemove "+copyEdges[toRemove].indexOf(unique));
						copyEdges[toRemove].remove(copyEdges[toRemove].indexOf(unique));
						id = toRemove;
						

					}

					ii++;
				}

				if(copyEdges[id].size() == 0)
				{						
					System.out.println(0);
					return;
				}	

				s.push(max);

				int prev = (int)s.pop();
				while(!s.empty() )
				{
					int current = (int)s.pop();
					//System.out.println("pr "+prev+" cu "+current);
					if(s.empty())
					{
						int index = isPresent(left, current)?left.indexOf(current):emptyCount/2+right.indexOf(current);
						// copyEdges[index].remove(copyEdges[index].indexOf(prev));
						copyEdges[emptyCount].remove(copyEdges[emptyCount].indexOf(current));
						//System.out.println("vertex removed "+current);
						//System.out.println("prev "+prev+" current "+current);
						//System.out.println("remaining vertices "+copyEdges[emptyCount] +" size "+copyEdges[emptyCount].size());
					}

					else
					{
						// //System.out.println(isPresent(left, current)?left.indexOf(current):(emptyCount/2+right.indexOf(current))+" indices "+left.indexOf(current)+" right "+(emptyCount/2+right.indexOf(current))+" copyEdges "+copyEdges[9]+" "+isPresent(left,current));
						int index = (isPresent(left, current)?left.indexOf(current):emptyCount/2+right.indexOf(current));			
						//System.out.println(" index "+index+" current "+current+ " copyEdges "+copyEdges[index]);
						copyEdges[index].remove(copyEdges[index].indexOf(prev));
						int next = (int)s.peek();
						copyEdges[index].addLast(next);
						//System.out.println("prev "+prev+" current "+current+" next "+next);
						prev = current;
					}
				}
				c++;

			}
			System.out.println(1);
			for(int i=emptyCount/2; i<emptyCount;i++)
			{
				int u = R[i - emptyCount/2];
				int v = (int)edges[i].get(0);
				// System.out.println(u+" matched edges "+v);
				System.out.println("("+(int)Math.ceil((float)u/n)+","+(u%n==0?n:u%n)+")"+"("+(int)Math.ceil((float)v/n)+","+(v%n==0?n:v%n)+")");
			}
		}
	}

	public static boolean isPresent(LinkedList R, int vertex)
	{
		for(int i=0; i<R.size(); i++)
		{
			if(vertex == R.get(i))
				return true;
		}
		return false;
	}
}