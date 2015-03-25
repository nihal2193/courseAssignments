import java.io.*;
import java.util.*;

class visible_lines
{
	public static void main(String arg[])
	{
		Scanner sc =  new Scanner(System.in);
		int testcases = sc.nextInt();

		 // System.out.println("no of testcases "+testcases);

		float[][] m = new float[testcases][2];
		
		float[][] origM = new float[testcases][2];		

		sc.nextLine();

		for(int i = 0; i < testcases; i++)
		{
			String line = sc.nextLine();
			// System.out.println("line "+line);
			String[] mc = line.split(":");

			m[i][0] = Float.parseFloat(mc[0]);
			m[i][1] = Float.parseFloat(mc[1]);
			origM[i][0] =  Float.parseFloat(mc[0]);
			origM[i][1] = Float.parseFloat(mc[1]);
			// System.out.println(m[i]+ "   "+c[i]);
		}

		

		Arrays.sort(m, new Comparator<float[]>()
			{
				public int compare(float[] a, float[] b)
				{
					return Float.compare(a[0],b[0]);
				}
			});
		
		// printArray(m);
		LinkedList<float[]> answer =  visible(m,0,testcases-1);
		// System.out.println(" no of visible line "+answer.size());

		int[] vis_lines = new int[answer.size()];

		for(int i=0;i<answer.size();i++)
		{
			
			vis_lines[i] = search(origM,answer.get(i));
			
		}
		Arrays.sort(vis_lines);
		for(int i = 0; i<vis_lines.length ; i++)
		{
			if(i == vis_lines.length - 1)
				System.out.print(vis_lines[i]);
			else
			{
				System.out.print(vis_lines[i]+",");
			}
		}

	}

	public static void printArray(float[] ar)
	{
		for(int i = 0; i<ar.length ; i++)
		{
			if(i == ar.length - 1)
				System.out.print(ar[i]);
			else
			{
				System.out.print(ar[i]+",");
			}
		}

	}

	public static int search(float[][] m1,float[] line)
	{
		int toreturn =-1;
		for(int i=0;i<m1.length;i++)
		{
			if(line[0] == m1[i][0] && line[1] == m1[i][1])
			{
				toreturn = i+1;
			}
			
		}
		return toreturn;

	}

	// mSortedLines lines sorted according to their slopes
	public static LinkedList<float[]> visible(float[][] mSortedLines,int start, int end)
	{
		LinkedList<float[]> vis = new LinkedList<float[]>();

		int length = mSortedLines.length;
		int mid =  ((end-start)/2)+start;
		
		// System.out.println(" start = "+start+" end "+end);

		if(start == end)
		{
			float[] line = new float[2];
			line[0] = mSortedLines[start][0];
			line[1] = mSortedLines[start][1];
			vis.addLast(line);
			 
			return vis;
		}

		else if(end - start == 1)
		{
			float[] line1 = new float[2];
			float[] line2 = new float[2];

			line2[0] = mSortedLines[end][0];
			line2[1] = mSortedLines[end][1];
			line1[0] = mSortedLines[start][0];
			line1[1] = mSortedLines[start][1];
			if(line1[0] == line2[0])
			{
				if(line1[1] > line2[1])
					vis.addLast(line1);
				else
					vis.addLast(line2);
			}
			else
			{
				vis.addLast(line1);
				vis.addLast(line2);
			}
			
			return vis;
		}

		else if(end - start == 2)
		{
			float[] line1 = new float[2];
			float[] line2 = new float[2];
			float[] line3 = new float[2];

			line3[0] = mSortedLines[end][0];
			line3[1] = mSortedLines[end][1];
			line1[0] = mSortedLines[start][0];
			line1[1] = mSortedLines[start][1];
			line2[0] = mSortedLines[start+1][0];
			line2[1] = mSortedLines[start+1][1];
			
			if(line1[0] == line2[0] && line2[0] == line3[0])
			{
				if(line1[1]>Math.max(line2[1] , line3[1]))
				{
					vis.addLast(line1);
				}
				else if (line2[1] > Math.max(line1[1],line3[1]))
				{
					vis.addLast(line2);
				}
				else 
					vis.addLast(line3);
			}

			else if(line1[0] == line2[0] || line2[0] ==  line3[0] || line3[0] == line1[0])
			{
				if(line1[0] == line2[0])
				{
					if(line1[1] > line2[1])
						vis.addLast(line1);
					else
						vis.addLast(line2);

					vis.addLast(line3);
				}
				else if(line2[0] == line3[0])
				{
					vis.addLast(line1);

					if(line2[1] > line3[1])
						vis.addLast(line2);
					else
						vis.addLast(line3);
				}
				else
				{
					if(line1[1] > line3[1])
						vis.addLast(line1);
					vis.addLast(line2);
					if(line1[1] < line3[1])
						vis.addLast(line3);

				}
			}

			else
			{		
				vis.addLast(line1);
				float xDiff = intersecPoint(mSortedLines[start],  mSortedLines[start+1])[0] - intersecPoint(mSortedLines[start+1], mSortedLines[end])[0];
				// System.out.println(" xDiff = "+xDiff);
				if(xDiff < 0)
					vis.addLast(line2);
				
				vis.addLast(line3);
			}
			return vis;

		}

		else
		{
			// System.out.println("left is called with start end as "+start+ " "+mid);
			LinkedList<float[]> leftVisible = visible(mSortedLines, start, mid);
			// System.out.println("right is called with start end as "+mid+1+ " "+end);
			LinkedList<float[]> rightVisible = visible(mSortedLines, mid+1, end);
			return merge(leftVisible,rightVisible);
		}

	}

	public static float[] intersecPoint(float[] m1c1, float[] m2c2)
	{
		// System.out.println(" intersecPoint called with args "+ m1c1[0] +" "+m1c1[1]+" "+m2c2[0]+" "+m2c2[1] );
		float[] f = new float[2];
		if(m1c1[0] != m2c2[0])
		{
			f[0] = (m2c2[1]-m1c1[1])/(m1c1[0]-m2c2[0]);
			f[1] = (m1c1[0]*m2c2[1]-m2c2[0]*m1c1[1])/(m1c1[0]-m2c2[0]);
		}
		else
		{
			f[0] = Integer.MIN_VALUE;
			f[1] = Integer.MIN_VALUE;
		}

		// System.out.println("intersecPoint output x = "+f[0]+" y = "+f[1]);
		return f;
	} 


	public static LinkedList<float[]> merge(LinkedList<float[]> leftVisible, LinkedList<float[]> rightVisible)
	{
		// System.out.println("leftVisible");
		for(int i=0;i<leftVisible.size();i++)
		{
			// printArray(leftVisible.get(i));
			// System.out.println("");
		}
		// System.out.println("rightVisible");
		for(int i=0;i<rightVisible.size();i++)
		{
			// printArray(rightVisible.get(i));
			// System.out.println("");
		}

		float[][] leftintersections = new float[leftVisible.size()][2];
		float[][] rightintersections = new float[rightVisible.size()][2];
		
		for( int i=0;i<leftVisible.size()-1;i++)
		{
			leftintersections[i+1] = intersecPoint(leftVisible.get(i),leftVisible.get(i+1));
			// System.out.println("left x = "+leftintersections[i+1][0]+ " y = "+leftintersections[i+1][1]);
		}

		for( int i=0;i<rightVisible.size()-1;i++)
		{
			rightintersections[i+1] = intersecPoint(rightVisible.get(i),rightVisible.get(i+1));
			// System.out.println("right x = "+rightintersections[i+1][0]+ " y = "+rightintersections[i+1][1]);
		}

		float[][] totalintersectoins = new float[leftVisible.size()+rightVisible.size()-2][2];


		int noOfPoints = 1;
		LinkedList<float[]> visible_lines_merged = new LinkedList<float[]>();
		int leftIsVisibleTill=leftVisible.size()-1;
		int rightIsVisibleFrom = 0;
		boolean lup = true;

		RightIsAlwaysUp:while(noOfPoints < leftintersections.length )		
		{
			
			float[] point = leftintersections[noOfPoints];
			float[] line = rightVisible.get(0);
			int counter = 0;
			boolean temp = true;
			while(yValue(line,point[0]) < point[1] && counter<rightVisible.size())
			{
				
				if(counter < rightVisible.size()-1)
					line = rightVisible.get(counter+1);
				// float[] cuttingLineRight = line;
				counter++;
			}

				
			
			

			if(counter < rightVisible.size())
			{
				// float maxY = yValue(line,point[0]);
				// for(int j = counter;j<rightVisible.size();j++)
				// {
				// 	float y = yValue(rightVisible.get(j),point[0]);
				// 	if( y > max)
				// 	{
				// 		maxY = yValue;

				// 	}
				// }

				if(yValue(line,point[0]) == point[1])
				{
					if(counter < rightVisible.size())
					{

						line = rightVisible.get(counter+1);
						if(yValue(line,point[0]) == point[1])
						{
							rightIsVisibleFrom = counter+1;
						}
						//need max slope for right and minimum slope for left
						// for(int j=counter;j<rightVisible.size();j++)
						// {
						// 	if(yValue(rightVisible.get(j),point[0]) == point[1] && maxSlope < rightVisible.get(j)[0])
						// 	{
						// 		rightIsVisibleFrom = j;
						// 	}

						// 	if(yValue())
						// }
						else
							rightIsVisibleFrom = counter;
					}
				}
				else
				{
					float minX = point[0];
					//yRight is greater
					rightIsVisibleFrom = counter;
					for(int j=counter ; j <rightVisible.size();j++)
					{
						// meed to check if there is an intersection of rightVisible before this x and after the previous x
						line = rightVisible.get(counter);
						if(yValue(line,point[0]) > point[1])
						{
							if(minX > intersecPoint(leftVisible.get(noOfPoints-1),line)[0])
							{
								if(j>0)
									rightIsVisibleFrom = j-1;
							}
						}

					}
				}
				temp = false;
				leftIsVisibleTill = noOfPoints-1;
				

				noOfPoints = leftintersections.length;
			}
			lup = lup && temp;
			visible_lines_merged.clear();
			for(int k = 0; k<=leftIsVisibleTill; k++)
			{
				visible_lines_merged.addLast(leftVisible.get(k));
			}
			for(int k = rightIsVisibleFrom; k<rightVisible.size();k++)
			{
				visible_lines_merged.addLast(rightVisible.get(k));	
			}
			noOfPoints++;

		}
		// System.out.println("left is up "+lup);
		if (lup)
		{
			
		noOfPoints = rightintersections.length-1;
	
		rightIsVisibleFrom = 0;
		LeftIsAlwaysUp:while(noOfPoints > 0)		
		{
			
			int lengthLV = leftVisible.size();
			float[] point = rightintersections[noOfPoints];
			float[] line = leftVisible.get(lengthLV-1);
			
		
			if(yValue(line,point[0]) >= point[1] )
			{
				
				// {
				// 	float y = yValue(rightVisible.get(j),point[0]);
				// 	if( y > max)
				// 	{
				// 		maxY = yValue;

				// 	}
				// }
				
				

				if(yValue(line,point[0]) == point[1])
				{
					if(lengthLV>1)
					{
							line = leftVisible.get(lengthLV-2);
						if(yValue(line,point[0]) == point[1])
						{
							leftIsVisibleTill = lengthLV - 2;
						}
						
					}
					else
					{
						leftIsVisibleTill = lengthLV-1;
					}

					
				}
					
				else
					leftIsVisibleTill = lengthLV-1;
					
				rightIsVisibleFrom = noOfPoints;
				

				noOfPoints = 0;


			}

			visible_lines_merged.clear();
			for(int k = 0; k<=leftIsVisibleTill; k++)
			{
				visible_lines_merged.addLast(leftVisible.get(k));
			}
			for(int k = rightIsVisibleFrom; k<rightVisible.size();k++)
			{
				visible_lines_merged.addLast(rightVisible.get(k));	
			}
			noOfPoints--;

		}

		}
		
		// System.out.println("merged lines are ");
		for(int i=0;i<visible_lines_merged.size();i++)
		{
			// printArray(visible_lines_merged.get(i));
			// System.out.println("");
		}
		
		return visible_lines_merged;
	}

	public static float yValue(float[] line, float xValue)
	{
		return line[0]*xValue+line[1];
	}

}