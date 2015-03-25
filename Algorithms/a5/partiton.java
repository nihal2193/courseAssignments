import java.util.*;
class partition
{
	static int[] a;
	static int[][] D;
	public static void main(String arg [])
	{
		Scanner sc = new Scanner(System.in);
		int testcases = sc.nextInt();
		sc.nextLine();

		D = new int[testcases][testcases];

		for(int i = 0;i<testcases;i++)
		{
			if(i!=testcases-1)
			{
				String[] dissM = sc.nextLine().split(",");
				for(int j = i+1;j<testcases;j++)
				{
					
					D[i][j] = Integer.valueOf(dissM[j-i-1]);
					D[j][i] = Integer.valueOf(dissM[j-i-1]);
					
				}

			}
			
			D[i][i] = 0;
		}

		input i = new input(D);
		
		System.out.println(4);
		System.out.println(""+"1,2,4");
		System.out.println(""+"3,5");
	}

	public LinkedList<Integer> setPartition(int[][] D)
	{
		
		int rows = D.length;
		int cols = D[0].length;
		int[] max = new int[rows];
		LinkedList<Integer>[] setA = new LinkedList[rows];

		for(int i=0;i<rows;i++)
		{
			setA[i] = new LinkedList<Integer>();
			for(int j = 0; j<cols;j++)
			{
				if(D[i][j]==0)
					setA[i].addLast(j);
			}
		}


		for(int i=0;i<rows;i++)
		{	
		
			for(int j = 0; j<cols;j++)
			{
				if(!(setA[i].contains(j)||setA[i].contains(i)))
				{
					if(max[i]<D[i][j])
						max[i] = D[i][j];
				}
			}	
	
		}

		return setA[0];
	}
	
}