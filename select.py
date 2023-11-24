import sys
in1 = sys.argv[1]
in2 = sys.argv[2]
# 打开包含个体名称和数值列的文件，假设文件名为data.csv
with open(in1, 'r') as file:
    lines = file.readlines()

# 创建一个列表用于存储每一列的数据
data = []

# 遍历文件的每一行数据
for line in lines:
    parts = line.strip().split('\t')
    
    # 假设第一列是个体名称，后面的列都是数值
    values = [float(value) for value in parts[1:]]
    
    # 将数值列的值添加到数据列表中
    data.append((parts[0], values))

# 计算列数
num_columns = len(data[0][1])

# 计算需要的个体数量，即每一列数值都在前10%的个体
required_individuals = int(len(data) * float(in2))

# 创建一个列表用于存储选定的个体
selected_individuals = []

# 遍历每一列的数据，选择每一列数值都在前10%的个体
for name, values in data:
    count = 0  # 用于计算每列中前10%的数值个数
    for column in range(num_columns):
        column_data = [row[1][column] for row in data]
        column_data.sort(reverse=True)  # 对数值进行降序排序，以选择数值大的个体
        if values[column] >= column_data[required_individuals - 1]:
            count += 1
    if count == num_columns:
        selected_individuals.append(name)

# 打印选定的个体的第一列信息（个体名称）
print("Top "+str(float(in2)*100) +"% combinations：")
for name in selected_individuals:
    print(name)

