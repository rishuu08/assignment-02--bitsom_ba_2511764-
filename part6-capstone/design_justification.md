# Storage Systems

The architecture uses three main storage systems: a data lake, a clinical data warehouse, and a time-series database, each chosen to support different use cases. The data lake is used to store raw data from multiple sources such as EHR systems, lab records, billing systems, and ICU devices. It is flexible and scalable, allowing both structured and unstructured data to be stored without strict schema requirements. This makes it ideal for ingesting large volumes of historical and streaming healthcare data.

The clinical data warehouse is used for structured, cleaned, and transformed data. It supports analytical queries and is optimized for reporting and machine learning tasks. For example, predicting patient readmission risk requires consistent and high-quality historical data, which is best provided by the warehouse. Similarly, the reporting layer uses warehouse data to generate monthly reports like bed occupancy and department-wise costs.

The time-series database is specifically used for storing real-time ICU vitals such as heart rate, blood pressure, and oxygen levels. Time-series databases are optimized for high-frequency data ingestion and fast querying over time intervals, making them ideal for monitoring and alert systems. This separation ensures efficient handling of both batch and streaming workloads.

## OLTP vs OLAP Boundary

In this architecture, the OLTP (Online Transaction Processing) systems include EHR systems, lab systems, and hospital billing systems. These systems handle day-to-day operations such as recording patient visits, updating treatment details, and processing billing transactions. They are optimized for fast inserts and updates and ensure data consistency.

The OLAP (Online Analytical Processing) system begins after the ingestion layer, specifically at the data lake and clinical data warehouse. Data from OLTP systems is extracted, transformed, and loaded (ETL) into analytical storage systems. The data warehouse serves as the main OLAP component where complex queries, reporting, and machine learning models operate.

The boundary between OLTP and OLAP lies at the ETL and data integration layer. This separation ensures that operational systems are not affected by heavy analytical queries. It also allows the analytical system to optimize for read-heavy workloads without impacting real-time transactional performance.

## Trade-offs

One significant trade-off in this design is between data latency and system complexity. By separating batch processing (ETL) and real-time streaming, the system becomes more complex to manage, as it requires multiple pipelines and storage systems. However, this separation is necessary to meet both real-time and analytical requirements.

Batch processing introduces some delay in updating the data warehouse, which may affect how current the reports and predictions are. On the other hand, real-time systems provide immediate insights but are more resource-intensive and harder to scale.

To mitigate this trade-off, a hybrid approach is used. Critical real-time data, such as ICU vitals, is processed through streaming pipelines and stored in a time-series database for instant analysis and alerts. Meanwhile, less time-sensitive data is processed in batches and stored in the data warehouse for accurate reporting and machine learning.

Additionally, data synchronization strategies such as micro-batching or near real-time ETL can be used to reduce latency while maintaining system efficiency. This approach balances performance, scalability, and accuracy while ensuring that both operational and analytical goals are met.