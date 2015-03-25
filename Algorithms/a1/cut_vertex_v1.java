import java.util.*;

class cut_vertex_v1
{


	private static int 	n;
	private static int[] depth;             //considers index 0 to be v1
	private static String[] 	vertex;     //considers index 0 to be v1
	private static LinkedList[] adjList;    //index 1 is the adjacency list of v1
	private static LinkedList dfsT = new LinkedList();   
	private static String[] parent;         //considers index 0 to be parent of v1
	private static String 	startVertex="v1"; 
	private static int maxDepth=0;
	private static LinkedList maxDepthVertices = new LinkedList();
	private static int[] lowCount;
	private static LinkedList[] vertexAtDepth;   //no vertex at depth 0 
	private static LinkedList[] childrenList;    //considers index 1 to be the list of children of v1
	private static int[] minimumNeighbourDepth; 
	private static boolean[] includedInSubTrees;  
	private static int cutVertexCount=0;
	private static LinkedList cutVertexCh;
	private static boolean rootIsCut = false;

	public static void main(String arg[])
	{
		Scanner 			sc 			= new Scanner(System.in);
		int 				testCases 	= sc.nextInt();
							
							adjList     = new LinkedList[testCases+1];
							vertex 		= new String[testCases];
							parent		= new String[testCases];
							n 			= testCases;
							depth 		= new int [n];	
							lowCount 	= new int [n];
							adjList[0]	= new LinkedList();
							minimumNeighbourDepth = new int[n];
							includedInSubTrees = new boolean[n];
							sc.nextLine();
		for( int i = 0 ; i < testCases ; i++ )
		{
			
			String		adjListString	=	sc.nextLine();
			String[]	vadjList		=	adjListString.split("->");
				        adjList[i+1]	= 	new LinkedList();
						vertex[i]		= 	vadjList[0];
						includedInSubTrees[i]=false;
					//	System.out.println(adjListString+"  vertex["+i+"] "+ vertex[i]);
			for( int j = 1 ; j < vadjList.length ; j++ )
			{
				
				adjList[i+1].addLast(vadjList[j]);
			
			}

			//System.out.println(adjList[i+1]);
		}

		int startIndex= Integer.parseInt(startVertex.substring(1))-1;
		parent[startIndex]="root";
		depth[startIndex]=1;
		maxDepth=1;
		dfsTree(adjList,startVertex);


	}

	public static void dfsTree( LinkedList[] adjList, String startVertex )
	{
		Stack s = new Stack();
		s.push(startVertex);
		
		boolean[] Discovered = new boolean [n];
		
		for( int i = 0 ; i < n ; i++ )
		{
			Discovered[i]=false;
		}

		while(!s.empty())
		{

			String 	current_vertex	= 	(String)s.pop();
		//	System.out.println("Pop "+current_vertex);
			int 	vindex 			= 	Integer.parseInt(current_vertex.substring(1))-1;      		//find( vertex , current_vertex );
			//System.out.println(vindex + "  "+ current_vertex);
			int 	degree 			= ((LinkedList)adjList[vindex+1]).size(); 

			if(Discovered[vindex]==false)
			{
				maxDepthVertices.clear();
				dfsT.addLast(current_vertex);

				Discovered[vindex]		=	true;

				while(degree-->0)
				{
					String beingPushed 	= (String)adjList[vindex+1].get(degree);
					int 	beingPushedIndex = Integer.parseInt(beingPushed.substring(1))-1;   			//find (vertex, beingPushed);
					// System.out.println("current vertex "+ current_vertex+" neigh "+beingPushed);
					if(!Discovered[beingPushedIndex])
					{
						depth[beingPushedIndex]		=	depth[vindex]+1;
						if(depth[beingPushedIndex]>=maxDepth)
						{
							maxDepthVertices.addLast(beingPushed);
							maxDepth=depth[beingPushedIndex];
						}
						parent[beingPushedIndex]	=	current_vertex;
						s.push(beingPushed);
						// System.out.println("Pushed "+beingPushed);
					}
				}

			}

		}

		

		vertexAtDepth = new LinkedList[maxDepth+1];   			// vertex at depth i is stored in list i
		setVertexAtDepthList(depth);
		setChildrenList(parent);								// setting the list which gives you the list of children of a vertex vi
		setMinimumNeighbourDepth();
		setLowCount();

		// System.out.println(dfsT);
		int size=n;
		while(size-->0)
		{
			// System.out.println("Parent of v"+(size+1)+" is "+parent[size]);
			// System.out.println("Depth of v"+(size+1)+" is "+depth[size]+ " vertex 0 "+vertex[0]+"  minimum nbdepth v6 "+minimumNeighbourDepth[5]);
		}

		cutVertexCh=new LinkedList();
		for(int i=0;i<n;i++)
		{
			
			if(parent[i].equals("root") && childrenList[i+1].size()>1 )
			{
				rootIsCut=true;
				cutVertexCh.addLast(childrenList[i+1].get(0));
				cutVertexCount++;
				cutVertexCh.addLast(childrenList[i+1].get(1));
				cutVertexCount++;
				
				// System.out.println("root is a cut vetex "+vertex[i]);
			}
			else
			{
				for(int j=0;j<childrenList[i+1].size() ;j++)
				{
					String ch =(String) childrenList[i+1].get(j);
					int chIndex=Integer.parseInt(ch.substring(1))-1;
					if(lowCount[chIndex]>=depth[i] && !parent[i].equals("root") )
					{
					
						cutVertexCh.addLast(ch);
						
						// System.out.println("cut vetex is "+vertex[i]+ " and child is "+ch);
						cutVertexCount++;
					}
				}
			}
		}
		
		ArrayList cutVertexAL =new ArrayList();
		LinkedList<LinkedList> component=new LinkedList<LinkedList>();


		for(int j=0;j<cutVertexCount;j++)
		{
			int cutVertexMaxDepth=0;
			String cutVertexChildMaxDepth=startVertex;
			for(int i=0;i<cutVertexCount;i++)
			{
					String cutVertexchild=(String)cutVertexCh.get(i);
					int cutVertexChildDepth = depth[Integer.parseInt(cutVertexchild.substring(1))-1];
					if(cutVertexChildDepth>cutVertexMaxDepth && !includedInSubTrees[Integer.parseInt(cutVertexchild.substring(1))-1])
					{
						cutVertexMaxDepth = cutVertexChildDepth;
						cutVertexChildMaxDepth=cutVertexchild;
					}
					
			}

			
			LinkedList component1=new LinkedList();
			component1=getSubTree(cutVertexChildMaxDepth);
			component1.addLast(parent[Integer.parseInt(cutVertexChildMaxDepth.substring(1))-1]);
			component.addLast(component1);

		}

		if(!rootIsCut)
			component.addLast(getSubTree(startVertex));



		int lines=component.size();
		System.out.println(lines);

		boolean printedcomp[]=new boolean[lines];
		for(int i=0;i<lines;i++)
		{
			printedcomp[i]=false;
		}

		for(int j=0;j<lines;j++)
		{
			int output_lines=component.size();			
			int min_size_component=n;
			
			
			int min_index=-1;
			for(int i=0;i<output_lines;i++)
			{
				LinkedList ith_comp=component.get(i);
			
				if(ith_comp.size()<=min_size_component && !printedcomp[i])
				{
					min_size_component=ith_comp.size();
					min_index=i;
				}

			}
			
				print_list(component.get(min_index));
				printedcomp[min_index]=true;

				if(j!=lines-1)
					System.out.println("");			
			// print_list(component.get(output_lines-1));
		}


	}

	

	public static void setLowCount( )
	{
		String lcvertex;
		int lcindex;
		for(int i=0;i<vertexAtDepth[maxDepth].size();i++)
		{
			lcvertex=(String)vertexAtDepth[maxDepth].get(i);
			lcindex= Integer.parseInt(lcvertex.substring(1))-1;
			lowCount[lcindex]=Math.min(depth[lcindex],minimumNeighbourDepth[lcindex]);
		}
		
		for(int i=maxDepth-1;i>1;i--)
		{
			for(int j=0;j<vertexAtDepth[i].size();j++)
			{
				lcvertex = (String)vertexAtDepth[i].get(j);
				lcindex	=	Integer.parseInt(lcvertex.substring(1))-1;
				int depthv = depth[lcindex];
				int minNbrDepth = minimumNeighbourDepth[lcindex];
				int minLc = maxDepth;
				for( int k=0;k<	childrenList[lcindex+1].size();k++)
				{
					String childV = (String) childrenList[lcindex+1].get(k);
					int childIndex= Integer.parseInt(childV.substring(1))-1; 
					if(minLc>lowCount[childIndex])
						minLc=lowCount[childIndex];
				}
				lowCount[lcindex]=Math.min(depthv,Math.min(minNbrDepth,minLc));
			}
		}

		
	}

	public static void setVertexAtDepthList(int [] depth)
	{
		for(int i=0;i<maxDepth+1;i++)
		{
			vertexAtDepth[i]=new LinkedList(); 				// at depth 0 there is no vertex for sake of simplicity
		}

		for(int i=0;i<depth.length;i++)
		{
			vertexAtDepth[depth[i]].addLast(vertex[i]);
		}

	}

	public static void setChildrenList(String[] parent)
	{
		childrenList = new LinkedList[n+1];
		for(int i=0;i<n+1;i++)
		{
			childrenList[i]=new LinkedList();
		}
		for(int i=0;i<parent.length;i++)
		{
			// System.out.println(" parent "+i+"  "+parent[i]);
			if(!parent[i].equals("root"))
				childrenList[Integer.parseInt(parent[i].substring(1))].addLast(vertex[i]);
		}
	}

	public static void setMinimumNeighbourDepth()
	{
		// minimumNeighbourDepth[i]=
		
		for(int i=0;i<n;i++)
		{
			int minDepth=depth[i];
			for(int j=0;j<adjList[i+1].size();j++)
			{
				String nbVertex  =  (String)adjList[i+1].get(j);
				if(!parent[i].equals(nbVertex))
				{

					int nbDepth=depth[Integer.parseInt(nbVertex.substring(1))-1];
					if (minDepth>nbDepth)
						minDepth=nbDepth;
				}

			}	
			minimumNeighbourDepth[i]=minDepth;
		}

	}

	public static LinkedList getSubTree(String vertex)
	{
		LinkedList subTree =new LinkedList();
		int vertexIndex=Integer.parseInt(vertex.substring(1))-1;
		if(!includedInSubTrees[vertexIndex])
		{
			subTree.addLast(vertex);
			includedInSubTrees[vertexIndex]=true;
		}
		for(int i=0;i<childrenList[vertexIndex+1].size();i++)
		{
			LinkedList subAns=new LinkedList();
			subAns=getSubTree((String)childrenList[vertexIndex+1].get(i));
			for(int j=0;j<subAns.size();j++)
			{
				subTree.addLast(subAns.get(j));	
			}
		}

		return subTree;
	}

public static void print_list(LinkedList L)
	{

		String[] vertices = new String[L.size()];
		for(int i=0;i<L.size();i++)
		{
			vertices[i]=(String)L.get(i);
		}
		
		Arrays.sort(vertices);
		for(int i=0;i<L.size()-1;i++)
		{
			System.out.print(vertices[i]+",");
		}
		
		System.out.print(vertices[L.size()-1]);
		
	}

}